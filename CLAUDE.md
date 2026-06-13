# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Context

On session start, read these files to orient before proceeding:
- `docs/rest-api.md` — REST API reference (v1.28+ features)
- `docs/graphql.md` — GraphQL API reference (Get, Aggregate, Explore, search operators)
- `docs/modules.md` — Vectorizer, generative, and reranker module catalog
- `TODO.md` — Outstanding work items and feature gaps

---

## Common Commands

```bash
# Run all unit tests (excludes live tests by default)
mix test

# Run a single test file
mix test test/api/schema_test.exs

# Run a single test by line number
mix test test/api/schema_test.exs:42

# Run live integration tests (requires running Weaviate instance)
mix test --include live

# Run only live tests
mix test --only live

# Compile
mix compile

# Format code
mix format

# Fetch dependencies
mix deps.get

# Start Weaviate for live tests
docker-compose up -d
```

### Weaviate Instance

The docker-compose stack runs Weaviate on `localhost:9004` (mapped from container port 8080) with transformer modules (text2vec, qna, ner, sum, img2vec) and generative-openai. The `OPENAI_API_KEY` env var must be set for generative features.

Config reads endpoint from `WEAVIATE_ENDPOINT` env var (defaults to `http://localhost:9004/`). API key from `WEAVIATE_API_KEY` env var (optional for local dev — anonymous access is enabled in docker-compose).

---

## Architecture

### Three-Layer Design

1. **API layer** (`lib/weaviate_api/`) — Thin wrappers around Weaviate REST endpoints. Each module (`Schema`, `Objects`, `Batch`, `Backups`, `Meta`, `Nodes`, `Auth`, `Classification`) maps 1:1 to a Weaviate REST resource. All API calls go through `Noizu.Weaviate.api_call/5` which handles HTTP via Finch, JSON encoding/decoding, and response dispatch.

2. **GraphQL layer** (`lib/weaviate_graph_ql/`) — Builder-pattern query construction. `Noizu.Weaviate.GraphQL` is the entry point; it delegates to `Get`, `Aggregate`, `Explore` structs. Search operators (`NearText`, `NearVector`, `BM25`, `Hybrid`, etc.) are separate structs under `search_operator/`. Queries implement `Jason.Encoder` so they serialize to GraphQL query strings when passed to `Api.Objects.query/2`.

3. **Struct/Class layer** (`lib/weaviate_structs/` + `lib/weaviate_classes/`) — Data types for Weaviate concepts. `Noizu.Weaviate.Class` provides the `weaviate_class` macro for defining Elixir modules that map to Weaviate collections. The macro generates: a struct with `meta` field, `definition/0` returning `Noizu.Weaviate.Struct.Class`, `from_json/1` for deserialization, and a `Jason.Encoder` impl.

### Request Flow

`Api.Objects.query(graphql_struct)` → `Noizu.Weaviate.api_call(:post, url, body, :json)` → `Finch.request(Noizu.Weaviate.Finch, ...)` → JSON decode response.

The Finch pool is started by `Noizu.Weaviate.Application` as a supervised child.

### Class Macro System

```elixir
defmodule MyClass do
  use Noizu.Weaviate.Class
  weaviate_class("MyClass") do
    description "..."
    vectorizer "text2vec-transformers"
    property :name, :string
    property :content, :text
  end
end
```

This generates:
- A struct with `:id`, `:meta`, and property fields
- `__class__/0`, `__properties__/0`, `__property__/1` introspection
- `definition/0` returning a `Noizu.Weaviate.Struct.Class` for schema creation
- `from_json/1` for deserializing API responses
- `Jason.Encoder` for serializing to API requests
- `Noizu.Weaviate.Class.Protocol` derivation for polymorphic dispatch

### Test Structure

- `test/api/` — Unit tests using Mimic to mock Finch HTTP calls
- `test/live/` — Integration tests against a real Weaviate instance (tagged `@moduletag :live`, excluded by default)
- `test/support/` — Test helper modules (e.g., `LiveArticle` class definition)

### Key Conventions

- All HTTP responses follow `{:ok, result} | {:error, term}` pattern
- GraphQL query structs implement `Jason.Encoder` to produce the GraphQL JSON body
- The `model` parameter in `api_call/5` controls response decoding: `nil` or `:json` returns raw decoded JSON, a module atom calls `Module.from_json/1`
- Endpoint base URL is a compile-time config (`Application.compile_env`) — changes require recompilation

---

## Tooling

- **Elixir**: 1.20.1-otp-29, **Erlang**: 29.0.2 (see `.tool-versions`)
- **HTTP**: Finch (connection pooling)
- **JSON**: Jason
- **Test mocking**: Mimic
- **Test output**: JUnit formatter (`results.xml`)
- **Published to**: Hex.pm as `:noizu_weaviate`
