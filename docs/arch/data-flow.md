# Data Flow

## Request Path

```
Application Code
    │
    ├─ GraphQL: Get/Aggregate/Explore struct
    │    │
    │    └─ Api.Objects.query/2
    │         │
    │         └─ POST /v1/graphql (body = Jason.encode!(struct))
    │
    └─ REST: Api.Schema.create/1, Api.Objects.list/2, etc.
         │
         └─ GET/POST/PUT/PATCH/DELETE /v1/{resource}
              │
              ▼
       Noizu.Weaviate.api_call/5
              │
              ├─ Jason.encode(body)
              ├─ Finch.build(method, url, headers, body)
              └─ Finch.request(Noizu.Weaviate.Finch, ...)
                    │
                    ▼
              Weaviate Instance
```

## Response Path

```
Finch.Response (status, body)
    │
    ├─ Jason.decode(body, keys: :atoms)
    │
    └─ Model dispatch:
         ├─ nil / :json → raw decoded map
         ├─ module atom → Module.from_json(json)
         └─ raw option → Module.from_binary(body)
```

## Streaming

When `options[:stream]` is set, `api_call/5` uses `Finch.stream/5` instead of `Finch.request/3`. The stream callback accumulates chunks into a `%{status, message, raw}` payload.

## Authentication

`headers/0` conditionally adds a `Bearer` token from `Application.get_env(:noizu_weaviate, :weaviate_api_key)`. When no key is configured (local dev with anonymous access), only the `Content-Type` header is sent.

## Timeouts

All Finch calls use 600-second timeouts for pool, receive, and request — accommodating large batch operations and slow vectorization.
