# Class Macro System

## Usage

```elixir
defmodule MyClass do
  use Noizu.Weaviate.Class
  weaviate_class("MyClass") do
    description "A sample collection"
    vectorizer "text2vec-transformers"
    property :name, :string
    property :content, :text
  end
end
```

## What the Macro Generates

1. **Struct** with `:id`, `:meta` (`Noizu.Weaviate.Class.Meta`), and all declared property fields
2. **Introspection** — `__class__/0`, `__properties__/0`, `__property__/1` for runtime reflection
3. **`definition/0`** — returns a `Noizu.Weaviate.Struct.Class` suitable for `Api.Schema.create/1`
4. **`from_json/1`** — deserializes a Weaviate API response into the struct
5. **`Jason.Encoder`** — serializes the struct for API requests
6. **`Noizu.Weaviate.Class.Protocol`** — derives the protocol for polymorphic dispatch (e.g., decoder resolution)

## Module Attributes

The macro registers accumulating/non-accumulating attributes during compilation:

| Attribute | Purpose |
|-----------|---------|
| `@properties` | Accumulated property definitions |
| `@class_description` | Collection description |
| `@class_vectorizer` | Vectorizer module name |
| `@class_vector_index_type` | HNSW / flat / dynamic |
| `@class_vector_index_config` | Index tuning parameters |
| `@class_module_config` | Module-specific configuration |
| `@class_replication_config` | Replication settings |
| `@class_multi_tenancy_config` | Multi-tenancy settings |
| `@class_sharding_config` | Sharding settings |
| `@class_inverted_index_config` | Inverted index settings |
| `@class_vector_config` | Named vector configuration |

## Meta Struct

Every class instance carries a `meta` field (`Noizu.Weaviate.Class.Meta`) with: `id`, `class`, `description`, `creation_time_unix`, `last_update_time_unix`, `vector`, `vectors`, `tenant`, `classification`, `feature_projection`.
