# Project Schema Summary

No relational store — schema surface is config env + struct data contract. Details: [PROJ-SCHEMA.md](PROJ-SCHEMA.md).

## Config (`config :noizu_weaviate`)

| Key | Type | Default | Notes |
|-----|------|---------|-------|
| `endpoint` | String | prod `http://api.weaviate.com/`; dev/test `http://localhost:9004/` (`WEAVIATE_ENDPOINT`) | Compile-time (`Application.compile_env`) |
| `weaviate_api_key` | String \| nil | nil (`WEAVIATE_API_KEY`) | Bearer token |

## Struct contract (`lib/weaviate_structs/`)

Class · Property · DataObject · Meta · Node · OpenIDConfiguration · Schema · VectorIndexConfig · InvertedIndexConfig (+BM25, Stopwords) · ReplicationConfig · MultiTenancyConfig · ShardingConfig · Tenant · BatchParams · BackupParams · ClassificationParams

Each mirrors a Weaviate JSON concept with `from_json/1` + `Jason.Encoder` (snake_case ↔ camelCase). Typo'd filenames `inverted_index_confix.ex`, `sharding_confix.ex`, `tenent.ex` define correctly-spelled modules.

## Interfaces

GraphQL builders (`lib/weaviate_graph_ql/`) → [graphql.md](graphql.md); REST wrappers (`lib/weaviate_api/`) → [rest-api.md](rest-api.md); class macro → [arch/class-macro.md](arch/class-macro.md).
