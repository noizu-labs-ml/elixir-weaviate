# AGENT.md — elixir-weaviate

Guidance for **Codex**, **Grok**, **Cursor**, and other `AGENTS.md` / `AGENT.md` tools.

Claude Code loads [CLAUDE.md](./CLAUDE.md). Same policy; this file is the harness-shaped sibling (numbered MUST first, markdown headings). If both this file and a parent `AGENTS.md` load, **this file wins on conflict**.

## MUST (every turn)

1. **Trinity Protocol REQUIRED**: Orientation → Friction → Response (full text: monorepo `protocols/the-trinity-protocol.md`).
2. **No shell in main thread** — delegate to taskers.
3. **Worktrees**: all work on worktrees; `epic.<group>` consolidation branches off `develop`; squash-PR provenance into epics.
4. MAIN checkout owns `deps/_build`; worktrees symlink deps (absolute path).
5. **PRs target `develop`.** Never merge or push `main` (CI/CD-only release path).

## Identity

Guidance for Claude Code. Monorepo ops → `../../../../../CLAUDE.md` (trl-infra root).

## Identity

Elixir Weaviate (vector DB) API client for Noizu apps. API-contract lib — align with the live Weaviate GraphQL/REST surface.

## Stack & Commands

Elixir. `mix deps.get && mix compile`; `mix test`; `mix format`, `mix credo`.

## Branch & PR Policy

- Submodules sit on **`develop`** — keep your checkout on `develop`.
- All PRs target **`develop`** (feature/bug/task branches fork from `develop`).
- **`main` is CI/CD-only**: CI/CD automation performs all merges into `main` (release path). Never merge to or push `main` by hand.

## Pointers

- Claude Code baseline: [CLAUDE.md](./CLAUDE.md)
