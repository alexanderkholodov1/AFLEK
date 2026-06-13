# aflek-sync.ps1 — keep an AFLEK adopter project in sync with the kit, automatically.
#
# The problem this solves: the kit (alexanderkholodov1/AFLEK) is the single source of truth for
# doctrine (playbooks, adapters, templates, personas, tools). Without sync, every project drifts —
# you would hand-edit N repos every time the kit changes. This makes it ONE command (and a
# SessionStart hook makes it zero — it runs on its own).
#
# What it does:
#   1. Pulls the kit clone from GitHub (the source of truth), unless -NoPull.
#   2. Materialises a read-only ".aflek/" snapshot of the kit's doctrine into the project — this is
#      what the orchestrator reads, so it never depends on an absolute path to the kit.
#   3. Refreshes the harness-live copies the project needs: reviewer personas -> .claude/agents.
#   4. Bumps the project's FLEET-VERSION to the kit's.
#   5. Reports exactly what changed (or, with -Check, what WOULD change — mutates nothing).
#
# Usage:
#   pwsh tools/aflek-sync.ps1 -Project "C:\path\to\repo"   # full sync
#   pwsh tools/aflek-sync.ps1 -Project . -Check            # drift report only
#
# Idempotent and safe to re-run. Never touches project-owned files (AGENTS.md, code, private/).

param(
  [string]$Project = (Get-Location).Path,
  [string]$Kit,
  [switch]$NoPull,
  [switch]$Check
)

$ErrorActionPreference = 'Stop'
function Info($m) { Write-Host "  $m" }
function Chg($m)  { Write-Host "  ~ $m" -ForegroundColor Yellow }
function Ok($m)   { Write-Host "  + $m" -ForegroundColor Green }

# Resolve the kit clone: -Kit, else $env:AFLEK_KIT, else the dir this script lives in.
if (-not $Kit) { $Kit = if ($env:AFLEK_KIT) { $env:AFLEK_KIT } else { Split-Path (Split-Path $PSCommandPath -Parent) -Parent } }
$Project = (Resolve-Path $Project).Path
if (-not (Test-Path (Join-Path $Kit 'FLEET-VERSION'))) { Write-Host "Not an AFLEK kit: $Kit" -ForegroundColor Red; exit 2 }

$mode = if ($Check) { "CHECK (no changes)" } else { "SYNC" }
Write-Host "AFLEK $mode — kit: $Kit -> project: $Project" -ForegroundColor Cyan

# 1. Pull the kit (source of truth) ──────────────────────────────────────────────────────────────
if (-not $NoPull -and -not $Check) {
  Push-Location $Kit
  try { git pull --ff-only 2>&1 | ForEach-Object { Info $_ } } catch { Chg "kit pull skipped: $_" }
  Pop-Location
}
$kitVer = (Get-Content (Join-Path $Kit 'FLEET-VERSION') -Raw).Trim()
$projVerFile = Join-Path $Project 'FLEET-VERSION'
$projVer = if (Test-Path $projVerFile) { (Get-Content $projVerFile -Raw).Trim() } else { '(none)' }

# 2. What the kit publishes into a project (the sync manifest). kit-path -> project-path.
#    Snapshot dirs are doctrine the orchestrator READS; they are regenerated, never hand-edited.
$snapshot = @('playbooks','adapters','doctrine','templates','tools','personas')
$changed = 0

$aflekDir = Join-Path $Project '.aflek'
foreach ($d in $snapshot) {
  $src = Join-Path $Kit $d
  if (-not (Test-Path $src)) { continue }
  $dst = Join-Path $aflekDir $d
  $diff = $true
  if (Test-Path $dst) {
    # cheap drift check: compare file lists + latest write
    $sh = (Get-ChildItem $src -Recurse -File | Sort-Object FullName | ForEach-Object { $_.Name + $_.Length }) -join ';'
    $dh = (Get-ChildItem $dst -Recurse -File | Sort-Object FullName | ForEach-Object { $_.Name + $_.Length }) -join ';'
    $diff = $sh -ne $dh
  }
  if ($diff) {
    $changed++
    if ($Check) { Chg ".aflek/$d would update" }
    else {
      if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
      New-Item -ItemType Directory -Force -Path $dst | Out-Null
      Copy-Item "$src\*" $dst -Recurse -Force
      Ok ".aflek/$d synced"
    }
  } else { Info ".aflek/$d up to date" }
}

# 3. Harness-live copies: reviewer personas -> .claude/agents (what Claude Code actually loads).
$personaSrc = Join-Path $Kit 'personas'
$agentsDst  = Join-Path $Project '.claude/agents'
if (Test-Path $personaSrc) {
  foreach ($p in Get-ChildItem $personaSrc -Filter *.md -File) {
    $target = Join-Path $agentsDst $p.Name
    $needs = -not (Test-Path $target) -or ((Get-FileHash $p.FullName).Hash -ne (Get-FileHash $target).Hash)
    if ($needs) {
      $changed++
      if ($Check) { Chg ".claude/agents/$($p.Name) would update" }
      else { New-Item -ItemType Directory -Force -Path $agentsDst | Out-Null; Copy-Item $p.FullName $target -Force; Ok ".claude/agents/$($p.Name) synced" }
    }
  }
}

# 4. FLEET-VERSION pin ────────────────────────────────────────────────────────────────────────────
if ($projVer -ne $kitVer) {
  $changed++
  if ($Check) { Chg "FLEET-VERSION $projVer -> $kitVer" }
  else { Set-Content -Path $projVerFile -Value $kitVer -NoNewline; Ok "FLEET-VERSION $projVer -> $kitVer" }
} else { Info "FLEET-VERSION $projVer (current)" }

# 5. Verdict ──────────────────────────────────────────────────────────────────────────────────────
Write-Host ""
if ($Check) {
  if ($changed -gt 0) { Write-Host "DRIFT: $changed item(s) behind the kit. Run without -Check to sync." -ForegroundColor Yellow; exit 1 }
  Write-Host "IN SYNC with kit $kitVer." -ForegroundColor Green; exit 0
}
Write-Host "Synced to kit $kitVer ($changed change(s)). Commit .aflek/, .claude/agents, FLEET-VERSION as one chore." -ForegroundColor Green
Write-Host "Note: .aflek/ is generated — never hand-edit it; edit the kit and re-sync." -ForegroundColor DarkGray
