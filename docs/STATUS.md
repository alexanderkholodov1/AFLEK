# The Fleet — build status board

> Updated at the close of every build wave. Plan of record:
> [`IMPLEMENTATION-PLAN.md`](IMPLEMENTATION-PLAN.md) (FWP-01…09).

_Last updated: 2026-06-12 (FWP-01/02/03 wave)_

## Build progress (v0.1)

| FWP | Deliverable | Status | PR |
|---|---|---|---|
| 01 | Bootstrap: LICENSE, FLEET-VERSION, doctrine, README quickstart | 🟡 PR open | #1 |
| 02 | `templates/AGENTS.template.md` + 4 shims | 🟡 PR open (stacked on 01) | #2 |
| 03 | CONTRIBUTING / changelog.d / STATUS / spec templates | 🟡 PR open (stacked on 02) | #3 |
| 04 | `templates/github/*` (CI, PR template, CODEOWNERS) | ⏳ | — |
| 05 | `personas/*` (4 reviewer personas, ECC-derived, attributed) | ⏳ | — |
| 06 | `adapters/*` (5 providers, last-verified dates) | ⏳ | — |
| 07 | `playbooks/*` (6 playbooks; 2 already seeded) | ⏳ | — |
| 08 | MunHub adoption pass (runs in MunHub) | ⏳ after 09 | — |
| 09 | Tag `v0.1.0` + repo description/topics | ⏳ | — |

Sequencing: 01 → 02 → {03,04,05} → 06 → 07 → 09 → 08.

## Maintainer action queue

1. Merge FWP PRs as they arrive (only the maintainer merges — doctrine rule 2).
2. **Make this repo public** once FWP-01 (MIT LICENSE) is merged — charter decision FD7 —
   then **protect `main`** (PR required; branch protection needs public repo on the free plan).
3. After FWP-09: announce the tag; MunHub adoption (FWP-08) follows as a normal MunHub PR.
