# Project Architecture Summary

Elixir client library for Weaviate vector database. OTP application supervising a Finch HTTP connection pool.

**Three layers**: REST API wrappers (1:1 with endpoints), GraphQL builder-pattern queries, and a macro-based class mapping system.

**Data flow**: App code → GraphQL/REST modules → `api_call/5` → Finch → Weaviate. Responses decode via Jason, optionally through `from_json/1`.

**Class macro**: `weaviate_class/2` generates struct, Jason.Encoder, `definition/0`, `from_json/1`, and protocol derivation from a DSL block.

**Stack**: Elixir 1.20/OTP 29, Finch (HTTP), Jason (JSON), Mimic (test mocking). Published to Hex.pm as `:noizu_weaviate`.
