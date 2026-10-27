# AGENT-README

> Orientation for AI coding agents working in this repo. Human docs: README.md.

## Type

elixir-lib

## Purpose

Weaviate (vector DB) REST + GraphQL API wrapper for Elixir (`Noizu.Weaviate`): schema/collection management, object CRUD, batch operations, GraphQL queries (Get, filters, search operators), backups, classification.

## Stack

Elixir (~> 1.14). Deps: Finch + Jason; mimic + junit_formatter for test. OTP app `:noizu_weaviate` v0.2.0 (`Noizu.Weaviate.Application`).

## Dev mode

```bash
mix deps.get && mix compile
```

## Ports / URLs

- none (library/CLI). Local test Weaviate (docker-compose.yml): `0.0.0.0:9004` → container `8080`.

## Tests

```bash
mix test
```

## Gotchas

- `test.exs` reads `WEAVIATE_ENDPOINT`; the dev endpoint is hardcoded (`config/dev.exs`).
- `docker-compose.yml` spins up `test-weaviate` (image `semitechnologies/weaviate:1.20.4`) on host port 9004 with text2vec/qna/ner/sum/img2vec inference sidecars; `OPENAI_API_KEY` is read from the environment for the generative module.
- The Weaviate API key is read per-request via `headers/0`; app config key is `config :noizu_weaviate, weaviate_api_key: ...`.
