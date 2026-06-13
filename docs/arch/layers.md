# Three-Layer Architecture

## 1. API Layer — `lib/weaviate_api/`

Thin wrappers around Weaviate REST endpoints. Each module (`Schema`, `Objects`, `Batch`, `Backups`, `Meta`, `Nodes`, `Auth`, `Classification`, `Cluster`) maps 1:1 to a Weaviate REST resource.

All API functions:
- Build a URL from `api_base()` + versioned path
- Call `Noizu.Weaviate.api_call/5` with HTTP method, URL, body, and model
- Return `{:ok, result} | {:error, term}`

`Api.Objects.query/2` is special — it accepts a GraphQL struct and POSTs it to `/v1/graphql`.

## 2. GraphQL Layer — `lib/weaviate_graph_ql/`

Builder-pattern query construction. `Noizu.Weaviate.GraphQL` is the entry point, delegating to `Get`, `Aggregate`, and `Explore` structs.

Search operators (`NearText`, `NearVector`, `BM25`, `Hybrid`, etc.) are separate structs under `search_operator/`. All query structs implement `Jason.Encoder` so they serialize to the JSON body format expected by Weaviate's GraphQL endpoint.

## 3. Struct/Class Layer — `lib/weaviate_structs/` + `lib/weaviate_classes/`

Data types for Weaviate concepts (collections, properties, nodes, backups, etc.) live in `weaviate_structs/`.

`Noizu.Weaviate.Class` provides the `weaviate_class/2` macro for defining Elixir modules that map to Weaviate collections. The macro generates a struct, JSON encoder, schema definition function, deserialization, and protocol derivation from a DSL block.
