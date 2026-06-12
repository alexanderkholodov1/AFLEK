# Research landscape — agent-fleet ecosystem (verified 2026-06)

> Quarterly review record (doctrine 3). Each entry: what it is, verdict for AFLEK, and what
> to watch. Next review due: **2026-09**.

## Standards (adopt — they ARE the strategy)

- **`AGENTS.md`** — the open agent-instruction standard (proposed by OpenAI 2025-08, donated
  to the Linux Foundation's Agentic AI Foundation 2025-12 alongside MCP; 60k+ repos; read
  natively by Codex, Copilot, Cursor, Gemini CLI, Aider, Windsurf, Zed…). **Verdict:** AFLEK's
  canonical-contract choice is the industry standard; shims exist only for harnesses with
  their own file (e.g. `CLAUDE.md`).
- **MCP** — the shared tool layer across providers. **Verdict:** the tool substrate, not the
  orchestrator; nothing for the kit to do beyond not fighting it.

## Shim/rules sync tools (adopt as optional tooling)

- **`intellectronica/ruler`** — single `.ruler/` source distributed to many assistants'
  config files. **`yelmuratoff/agent_sync`** — one source synced to 11 harnesses (Claude,
  Copilot, Cursor, Gemini, Codex, Windsurf, Junie, Cline, Amazon Q, Zed, Antigravity).
  **Verdict:** mechanize doctrine 5 (shims never drift) for adopters with many harnesses;
  AFLEK's hand-written shims remain the zero-dependency default.

## Spec-driven development (interoperate)

- **`github/spec-kit`** — agent-agnostic SDD toolkit (Spec → Plan → Tasks → Implement;
  ~30 agent integrations; the most-adopted SDD tool of 2026). **Verdict:** complementary,
  not competing — spec-kit owns the spec pipeline inside a feature; AFLEK owns the fleet
  layer around it (contracts, gates, routing, review, memory). An adopter can use spec-kit
  as the engine behind `templates/spec.template.md`; candidate for a v0.2 `adapters/`-style
  interop note.

## Swarm runtimes (do NOT adopt as core — doctrine: kit-not-runtime)

- **`ruvnet/ruflo`** (ex-claude-flow, renamed 2026-01; ~31k stars) — multi-agent swarm
  meta-harness: multi-provider routing (Anthropic/OpenAI/Google/xAI/Mistral/Ollama),
  cost-based failover, vector memory, RL components. **Verdict:** impressive but the
  opposite trade: a heavy runtime that competes with vendors' own cloud surfaces and rots
  with their churn. Watch for ideas (cost-based routing tables, mixed-provider swarms);
  an adopter who truly needs local swarm execution can wrap it behind a normal adapter
  file — the PR-gated contract absorbs any executor.
- **`nwiizo/ccswarm`** — Claude-Code multi-agent orchestration with git-worktree isolation.
  **Verdict:** same genus, same verdict; its worktree-isolation pattern is already AFLEK
  practice (one worktree per task).

## Self-improvement / memory systems (adopt the pattern, not the engine)

- **Hermes Agent (Nous Research)** — persistent cross-session memory + self-improving skill
  library. **`lsdefine/GenericAgent`** — self-evolving skill tree from a small seed.
  **`cognee`** — graph+vector+relational memory store. **ECC `continuous-learning-v2`** —
  instinct/memory pattern for Claude Code (still unproven at scale).
  **Verdict:** the convergent industry pattern matches `playbooks/learning-loop.md`: skills/
  lessons as small reviewable artifacts that survive sessions. AFLEK keeps the substrate in
  git (markdown, PR-gated); engines like cognee are per-project choices, not kit deps.

## Previously evaluated (2026-06, recorded in the first adopter's audit)

- **`everything-claude-code` (ECC)** — persona/rules source; cherry-picked at a pinned
  commit (see `personas/` headers). Never install wholesale (token bloat, hook fragility).
- **OpenClaw** — personal-assistant gateway; disqualifying security record. **Hermes as
  gateway** — same genus; its coding-CLI orchestration was an open feature request.
  Both: out of scope (doctrine 3).
