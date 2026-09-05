# CLAUDE.md — elixir-weaviate

Guidance for Claude Code. Monorepo ops → `../../../../../CLAUDE.md` (trl-infra root).

## Identity

Elixir Weaviate (vector DB) API client for Noizu apps. API-contract lib — align with the live Weaviate GraphQL/REST surface.

## Stack & Commands

Elixir. `mix deps.get && mix compile`; `mix test`; `mix format`, `mix credo`.

## Universal Rules (compressed)

- **Trinity Protocol REQUIRED**: Orientation → Friction → Response (full text: monorepo `protocols/the-trinity-protocol.md`).
- **No shell in main thread** — delegate to taskers.
- **Worktrees**: all work on worktrees; `epic.<group>` consolidation branches off `develop`; squash-PR provenance into epics.
- MAIN checkout owns `deps/_build`; worktrees symlink deps (absolute path).

## Branch & PR Policy

- Submodules sit on **`develop`** — keep your checkout on `develop`.
- All PRs target **`develop`** (feature/bug/task branches fork from `develop`).
- **`main` is CI/CD-only**: CI/CD automation performs all merges into `main` (release path). Never merge to or push `main` by hand.
