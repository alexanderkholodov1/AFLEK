# AFLEK — Agent Fleet Kit

> A **project-agnostic, provider-agnostic agent fleet kit**: drop it into any repository — new
> or existing, web, full-stack, research, anything — and get a working multi-agent development
> system: command structure, quality gates, work-packaging format, reviewer personas, and
> provider adapters, without rebuilding the machinery every time. Extracted from a real
> production project (its first adopter), hardened by the failures recorded in
> [`doctrine/DOCTRINE.md`](doctrine/DOCTRINE.md).

**Status:** v0.1 complete — see [`docs/STATUS.md`](docs/STATUS.md).

## Quickstart — adopt AFLEK in a repo

1. **Pin a kit version.** Copy `FLEET-VERSION` from a tagged release of this repo into your
   repo's root. Upgrades are deliberate (see `playbooks/upgrade-kit-version.md`), never implicit.
2. **Instantiate the contract.** Fill the `{{PLACEHOLDERS}}` in `templates/AGENTS.template.md`
   → your repo's `AGENTS.md`; instantiate the shims from `templates/shims/` so every harness
   points at it. Add your project's domain guardrails in the marked section — they live in
   your repo, not in the kit.
3. **Install the gates.** Instantiate `templates/github/` (CI + secret scan, PR template,
   CODEOWNERS), `templates/CONTRIBUTING.template.md`, `templates/STATUS.template.md`, and the
   `changelog.d/` pattern. Protect `main`: PR + green CI required; only the human merges.
4. **Run waves.** Cut work into work packages (`templates/work-package.md`), route them to
   cloud agents per `adapters/`, review per `personas/`, and close every wave by updating the
   status board (`playbooks/run-a-wave.md`).

New empty repo? Start at `playbooks/bootstrap-new-project.md`. Existing repo?
`playbooks/adopt-existing-repo.md`.

## Any provider, by construction

AFLEK does not depend on any vendor's agent. Three mechanisms make it work with **everything**:

- **The canonical contract is `AGENTS.md`** — the open standard (Linux Foundation, read
  natively by Codex, Copilot, Cursor, Gemini CLI, Aider, Windsurf, Zed, and more). Harnesses
  that read their own file instead get a thin shim pointing at it (`templates/shims/`); sync
  tools like `intellectronica/ruler` or `agent_sync` can generate shims for a dozen harnesses
  from one source.
- **The deliverable is a PR gated by CI** — the one artifact every agent on earth can emit.
  No runtime integration is ever required.
- **New providers are an adapter file away** — `adapters/TEMPLATE.md` adds any current or
  future provider in minutes. Shipped adapters: Claude Code, Cursor, Gemini, Copilot, Codex.

## Doctrine (lessons already paid for)

> Summary only — [`doctrine/DOCTRINE.md`](doctrine/DOCTRINE.md) is authoritative: each rule
> with rationale and the concrete failure it prevents.

1. **Cloud-first execution.** Implementer agents run on cloud surfaces — never as parallel
   processes on the operator's machine. Local CLIs are for single interactive sessions only.
2. **The PR is the deliverable; CI is the referee.** Agents commit to feature branches, open
   PRs; protected `main`; only the human merges.
3. **No gateway products in the loop.** Personal-assistant gateways are out of scope: wrong
   genus (chat assistants, not build orchestrators). Re-evaluate the landscape quarterly.
4. **The work package is the unit of delegation.** If a mid-tier model can't execute a WP
   alone, the WP is underspecified — fix the WP, not the model.
5. **One canonical contract, thin shims.** A single `AGENTS.md` is the authority; per-harness
   shims are pointers that must never drift.
6. **No chat-dependent state.** Sessions end with pushed branches, PR stage reports, and a
   status-board update. Any plan of record lives in the repo.
7. **Routing by strength, reviewing across providers.** Frontier designs and reviews; mid-tier
   implements; cheap tier does bulk; a *different* provider reviews each PR.

## Self-improvement (the kit learns)

AFLEK improves the way it does everything else — **through PRs, not through a runtime**:
`playbooks/learning-loop.md` turns wave retrospectives into concrete edits to doctrine,
templates, personas, and playbooks. Adopting projects learn privately in their own fork/layer
and upstream the generalizable lessons. See `docs/RESEARCH-LANDSCAPE.md` for how this compares
to runtime-based self-learning systems.

## Repo map

```
aflek/
├─ README.md            this charter + quickstart
├─ FLEET-VERSION        the kit's own version (SemVer; adopters pin it)
├─ doctrine/            the 7 rules, each with rationale + the failure it prevents
├─ templates/           AGENTS.md contract, shims, CONTRIBUTING, PR template, CI workflow,
│                       changelog.d, STATUS board, work-package + spec templates
├─ personas/            reviewer personas (code, security, silent-failure, docs) — harness-neutral
├─ adapters/            per-provider operating notes + TEMPLATE.md to add any new one
├─ playbooks/           bootstrap, adopt-existing-repo, run-a-wave, phase-audit,
│                       learning-loop, upgrade-kit-version, incident
└─ docs/                status board, build history, research landscape
```

## Explicit non-goals

- Building an orchestration runtime/daemon. The vendors' cloud surfaces are the runtime; AFLEK
  is contracts, templates, and playbooks — the part that survives vendor churn.
- Tracking every new agent tool. Quarterly landscape review; adopt only what removes a step.

## License

MIT. Reviewer personas adapted from `everything-claude-code` (MIT) carry attribution headers
with the pinned source commit.
