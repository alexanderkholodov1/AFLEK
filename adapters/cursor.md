# Adapter — Cursor

> **Last verified:** 2026-06-12 (first adopter's landscape audit). Re-verify quarterly
> (doctrine 3).

## Where it runs

| Surface | Use for |
|---|---|
| **Cloud Agents** (cursor.com dashboard / IDE) | implementer WPs in the cloud — the doctrine-1 surface |
| **IDE (local)** | the operator's own editing; not an agent execution surface for AFLEK |
| **Bugbot** (PR review bot) | automated PR review — see billing caution |

## How to start a task

Cloud Agent: from the dashboard or IDE, point it at the repo, give it the work package
text, one spec per branch/PR. It commits to a branch and opens the PR itself.

## Shim wiring

Reads `.cursor/rules/*.mdc`. Instantiate `templates/shims/cursor-rules.template.mdc` as
`.cursor/rules/00-agents.mdc` with `alwaysApply: true` — Cloud Agents and the IDE both
load it.

## Strengths / routing

Strong at UI/front-end lanes and iterative in-editor work. Route UI work packages here;
keep contracts and physics-grade logic with the frontier lane (doctrine 7).

## Cost / billing cautions

- Cloud Agents consume the plan's usage allowance; monitor the dashboard during heavy waves.
- **Bugbot is usage-billed separately** — the first adopter turned it OFF (2026-06-12) and
  replaced it in the review ensemble with Copilot review + Claude personas. If you enable
  Bugbot, set a spending cap first.
- Plan limits reset monthly; a stalled agent retrying in a loop can quietly drain a month's
  allowance — kill stuck agents from the dashboard.
