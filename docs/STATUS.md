# AFLEK — status board

> Updated at the close of every build wave. Build history: [`IMPLEMENTATION-PLAN.md`](IMPLEMENTATION-PLAN.md).

_Last updated: 2026-06-13 (rename + adaptability wave)_

## Version

| Milestone | Status |
|---|---|
| v0.1 content (FWP-01…08) | ✅ complete — all merged; first adopter pinned `0.1.0` |
| Rename to **AFLEK** + privacy sweep + adaptability set | 🟡 PR open |
| Tag `v0.1.0` (FWP-09) | ⏳ after the rename PR merges |
| v0.2 candidates | see IMPLEMENTATION-PLAN §5 + `RESEARCH-LANDSCAPE.md` |

## Build record (v0.1)

| FWP | Deliverable | PR |
|---|---|---|
| 01 | Bootstrap: LICENSE, FLEET-VERSION, doctrine, quickstart | #1 ✅ |
| 02 | `templates/AGENTS.template.md` + 4 shims | #2 ✅ |
| 03 | CONTRIBUTING / changelog.d / STATUS / spec templates | #3 ✅ |
| 04 | `templates/github/*` (CI, PR template, CODEOWNERS) | #4 ✅ |
| 05 | `personas/*` (4 reviewer personas, attributed) | #5 ✅ |
| 06 | `adapters/*` (5 providers) | #6 ✅ |
| 07 | `playbooks/*` (6 playbooks) | #7 ✅ |
| 08 | First-adopter adoption pass (in the adopter's repo) | ✅ |
| 09 | Tag `v0.1.0` + repo description/topics | description/topics ✅ · tag ⏳ |

## Maintainer action queue

1. Merge the rename/adaptability PR.
2. Orchestrator tags `v0.1.0` (release notes from the FWP table above).
3. Optional: rename the GitHub repo URL to `aflek` (redirects preserve old clones/pins).
