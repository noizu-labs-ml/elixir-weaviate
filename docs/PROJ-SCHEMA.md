# Project Schema

`noizu_weaviate` is a client library with **no relational store, no KV layer, and no data files** — there is nothing to ERD. The structured data in this repo is: (1) the application configuration schema, and (2) the struct data contract that mirrors Weaviate's JSON wire format. Both are documented here. Wire-format references (GraphQL queries, REST payloads) live in [graphql.md](graphql.md) and [rest-api.md](rest-api.md); file locations are mapped in [PROJ-LAYOUT.md](PROJ-LAYOUT.md).

## Configuration Schema (`config :noizu_weaviate`)

| Key | Type | Default | Source | Description |
|-----|------|---------|--------|-------------|
| `endpoint` | `String.t()` | `"http://api.weaviate.com/"` (prod) / `"http://localhost:9004/"` (dev, test) | `config/{env}.exs`; test/dev read `WEAVIATE_ENDPOINT` | Weaviate base URL. **Compile-time** — baked into `Noizu.Weaviate` via `Application.compile_env/3`; changing it requires recompiling consumers |
| `weaviate_api_key` | `String.t() \| nil` | `nil` | `WEAVIATE_API_KEY` env | API key sent as bearer token on every request |

Related (not library-owned): `config :junit_formatter, report_file: "results.xml"` in dev/test.

## Data Contract — `weaviate_structs/`

Each struct in `lib/weaviate_structs/` mirrors a Weaviate JSON concept, with `from_json/1` (camelCase JSON → snake_case struct) and a `Jason.Encoder` impl (struct → camelCase JSON). This is the library's typed surface over the wire format.

| Struct | Mirrors | Key fields |
|--------|---------|-----------|
| `Class` | Collection schema object | `name` (from `class`), `vectorizer`, `vector_index`, `properties`, `module_config`, plus nested configs below |
| `Property` | Collection property | `data_type` (`dataType`), `tokenization`, `index_filterable`/`index_searchable`/`index_inverted`/`index_range_filters`, `nested_properties` |
| `DataObject` | Stored data object | `class_name`, `properties` (enforced), `id`, `vector`, `additional_properties`, `tenant` |
| `Meta` | `GET /v1/meta` response | hostname, version, modules |
| `Node` | `GET /v1/nodes` entry | name, status, version, gitHash, stats |
| `OpenIDConfiguration` | `.well-known/openid-configuration` | issuer, clientId, authEndpoint |
| `Schema` | `GET /v1/schema` response | list of classes |
| `VectorIndexConfig` | Vector index tuning | per-index-type params (map-typed in part) |
| `InvertedIndexConfig` (+ `BM25`, `Stopwords`) | Inverted index tuning | cleanupIntervalSeconds, bm25, stopwords |
| `ReplicationConfig` | Replication settings | factor, deletion_strategy, async_enabled |
| `MultiTenancyConfig` | Multi-tenancy settings | enabled, auto_tenant_creation, auto_tenant_activation |
| `ShardingConfig` | Sharding settings | virtual_per_physical, desired/actual_count, desired/actual_virtual_count, key, strategy, function |
| `Tenant` | Multi-tenant collection tenant | name, activity_status (used with DataObject `tenant`) |
| `BatchParams` / `BackupParams` / `ClassificationParams` | Request-parameter objects for batch/backup/classification calls | varies |

Quirk worth knowing: three struct **filenames** carry typos — `inverted_index_confix.ex`, `sharding_confix.ex` ("confix"), and `tenent.ex` — but the modules they define are spelled correctly (`InvertedIndexConfig`, `ShardingConfig`, `Tenant`). Cosmetic only; renaming files is safe, renaming modules is a breaking API change.

## Interface Schemas

- **GraphQL**: builder-pattern query construction — see [graphql.md](graphql.md) and `lib/weaviate_graph_ql/` (search operators: `near_text`, `near_vector`, `hybrid`, `bm25`, `ask`, `near_{object,image,audio,video,depth,thermal,imu}`, `group`; builders: `Get`, `Aggregate`, `Explore`, `Where`, `GroupBy`, `Additional`).
- **REST**: endpoint wrappers in `lib/weaviate_api/` — see [rest-api.md](rest-api.md) (schema, objects, batch, backups, classification, nodes, cluster, meta, authz, well_known).
- **Class macro**: `Weaviate.Classes` `weaviate_class/2` macro maps an Elixir module to a collection — see [arch/class-macro.md](arch/class-macro.md).
