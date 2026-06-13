# Noizu.Weaviate - README

Noizu.Weaviate is an Elixir library providing a wrapper around Weaviate's REST and GraphQL APIs. It supports schema/collection management, object CRUD, batch operations, GraphQL queries (Get, filters, search operators), backups, classification, and more.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
    - [Defining Schema Classes](#defining-schema-classes)
    - [Creating Objects](#creating-objects)
    - [Editing Objects](#editing-objects)
    - [Deleting Objects](#deleting-objects)
    - [GraphQL Queries](#graphql-queries)
- [API Modules](#api-modules)
    - [Noizu.Weaviate.Api.Meta](#noizuweaviateapimeta)
    - [Noizu.Weaviate.Api.Batch](#noizuweaviateapibatch)
    - [Noizu.Weaviate.Api.Backups](#noizuweaviateapibackups)
    - [Noizu.Weaviate.Api.Schema](#noizuweaviateapischema)
    - [Noizu.Weaviate.Api.Nodes](#noizuweaviateapinodes)
    - [Noizu.Weaviate.Api.Objects](#noizuweaviateapiobjects)
    - [Noizu.Weaviate.Api.Auth](#noizuweaviateapiauth)
    - [Noizu.Weaviate.Api.Classification](#noizuweaviateapiclassification)
- [GraphQL Module](#graphql-module)
- [API Reference Docs](#api-reference-docs)
- [Weaviate Feature Coverage](#weaviate-feature-coverage)

## Installation

You can install Noizu.Weaviate by adding it as a dependency in your `mix.exs` file:

```elixir
def deps do
  [
    {:noizu_weaviate, "~> 0.1.0"}
  ]
end
```

Then, run `mix deps.get` to fetch the dependency.

## Configuration

To configure Noizu.Weaviate, you need to set the Weaviate API key in your application's configuration. Update your `config/config.exs` file with the following configuration:

```elixir
config :noizu_weaviate,
  weaviate_api_key: "your_api_key_here"
```

## Usage

Noizu.Weaviate provides an easy-to-use API for working with Weaviate schema and objects.

### Defining Schema Classes

To define a schema class, you can use the `Noizu.Weaviate.Class` module and the `weaviate_class` macro. Here's an example:

```elixir
defmodule Product do
  use Noizu.Weaviate.Class
  weaviate_class("Product") do
      description "A class for representing products in Weaviate"
    
      property :name, :string
      property :price, :number
      property :description, :text
  end
end
```

### Creating Objects

You can create objects using the `Noizu.Weaviate.Api.Objects.create` function. Here's an example:

```elixir
object = %Product{name: "iPhone 12", price: 999.99, description: "The latest iPhone model"}
{:ok, response} = Noizu.Weaviate.Api.Objects.create(object)
```

### Editing Objects

You can edit objects using the `Noizu.Weaviate.Api.Objects.update` function. Here's an example:

```elixir
object = %Product{id: "object_id", name: "New iPhone 12", price: 1099.99, description: "The new iPhone model"}
{:ok, response} = Noizu.Weaviate.Api.Objects.update(object)
```

### Deleting Objects

You can delete objects using the `Noizu.Weaviate.Api.Objects.delete` function. Here's an example:

```elixir
{:ok, response} = Noizu.Weaviate.Api.Objects.delete("class_name", "object_id")
```

## API Modules

Noizu.Weaviate provides several API modules for working with Weaviate. Here's an overview of the available modules and their functionalities:

### Noizu.Weaviate.Api.Meta

This module provides functions for getting meta information about the Weaviate instance. You can get information about the Weaviate version, host, and more.

See [Noizu.Weaviate.Api.Meta README](lib/weaviate_api/meta/README.md) for more details.

### Noizu.Weaviate.Api.Batch

This module provides functions for batch operations in Weaviate. You can batch create objects and references, as well as batch delete objects.

See [Noizu.Weaviate.Api.Batch README](lib/weaviate_api/batch/README.md) for more details.

### Noizu.Weaviate.Api.Backups

This module provides functions for working with backups in Weaviate. You can create backups, get backup status, restore backups, and get restore status.

See [Noizu.Weaviate.Api.Backups README](lib/weaviate_api/backups/README.md) for more details.

### Noizu.Weaviate.Api.Schema

This module provides functions for working with the Weaviate schema. You can create, get, update, and delete classes, properties, shards, and tenants.

See [Noizu.Weaviate.Api.Schema README](lib/weaviate_api/schema/README.md) for more details.

### Noizu.Weaviate.Api.Nodes

This module provides functions for getting information about the Weaviate nodes. You can get information about the connected nodes in the Weaviate cluster.

See [Noizu.Weaviate.Api.Nodes README](lib/weaviate_api/nodes/README.md) for more details.

### Noizu.Weaviate.Api.Objects

This module provides functions for interacting with data objects in Weaviate. You can create, get, update, patch, delete, and validate objects.

See [Noizu.Weaviate.Api.Objects README](lib/weaviate_api/objects/README.md) for more details.

### Noizu.Weaviate.Api.Auth

This module provides functions for authentication in the Weaviate API. You can get the OpenID configuration, check the liveness of the Weaviate instance, and check the readiness of the Weaviate instance.

See [Noizu.Weaviate.Api.Auth README](lib/weaviate_api/well_known/README.md) for more details.

### Noizu.Weaviate.Api.Classification

This module provides functions for classification operations in Weaviate. You can start a classification, get the status of a classification, and cancel a classification.

See [Noizu.Weaviate.Api.Classification README](lib/weaviate_api/classification/README.md) for more details.

For more detailed documentation on all available functions and options, please refer to the individual module readmes provided above.

## GraphQL Module

`Noizu.Weaviate.GraphQL` provides a builder-pattern API for constructing Weaviate GraphQL queries.

### Basic Get Query

```elixir
alias Noizu.Weaviate.GraphQL

query = GraphQL.get("Article")
  |> GraphQL.properties(["title", "content", "wordCount"])
  |> GraphQL.limit(10)
  |> GraphQL.additional([:id, :distance, :creation_time])

# With vector search
query = GraphQL.get("Article")
  |> GraphQL.properties(["title", "content"])
  |> GraphQL.search_operator(%{nearText: %{concepts: ["machine learning"]}})
  |> GraphQL.limit(5)
  |> GraphQL.additional([:id, :distance])

# With hybrid search
query = GraphQL.get("Article")
  |> GraphQL.properties(["title", "content"])
  |> GraphQL.search_operator(%{hybrid: %{query: "machine learning", alpha: 0.75}})
  |> GraphQL.autocut(1)

# With where filter
alias Noizu.Weaviate.GraphQL.Where

filter = Where.and_operator(
  Where.equal("category", "Technology"),
  Where.greater_than("wordCount", 500)
)

query = GraphQL.get("Article")
  |> GraphQL.properties(["title", "content"])
  |> GraphQL.where(filter)
  |> GraphQL.sort(%{path: ["title"], order: :asc})

# With groupBy
query = GraphQL.get("Article")
  |> GraphQL.properties(["title"])
  |> GraphQL.search_operator(%{nearText: %{concepts: ["AI"]}})
  |> GraphQL.group_by("category", 5, 3)
```

### Available Search Operators

| Operator | Description | Status |
|----------|-------------|--------|
| `nearText` | Semantic text search | Implemented |
| `nearVector` | Raw vector similarity | Implemented |
| `nearObject` | Similar to existing object | Implemented |
| `nearImage` | Image similarity | Implemented |
| `bm25` | Keyword (BM25) search | Implemented |
| `hybrid` | Combined vector + keyword | Implemented |
| `ask` | Question answering | Implemented |
| `group` | Grouping (deprecated) | Implemented |
| `nearAudio` | Audio similarity | Not yet |
| `nearVideo` | Video similarity | Not yet |
| `nearDepth` | Depth map similarity | Not yet |
| `nearThermal` | Thermal image similarity | Not yet |
| `nearIMU` | IMU sensor data similarity | Not yet |

See [GraphQL API Reference](docs/graphql.md) for full details including Aggregate queries, Explore queries, generative search (RAG), reranking, named vectors, and multi-tenancy.

## API Reference Docs

Comprehensive API reference documentation covering the latest Weaviate features (v1.28+):

- **[GraphQL API Reference](docs/graphql.md)** - Get, Aggregate, Explore queries; search operators; filters; additional properties; generative search; reranking; named vectors
- **[REST API Reference](docs/rest-api.md)** - All REST endpoints; collections/schema; objects; batch; backups; RBAC; multi-tenancy; cluster
- **[Modules Reference](docs/modules.md)** - Vectorizer, generative, and reranker module catalog with configuration examples

## Weaviate Feature Coverage

Summary of library coverage vs. current Weaviate API surface (v1.28+):

| Feature Area | Status | Notes |
|-------------|--------|-------|
| Schema/Collection CRUD | Implemented | Classes, properties, shards, tenants |
| Object CRUD | Implemented | Create, get, update, patch, delete, validate |
| Batch Operations | Implemented | Batch create/delete objects, batch create references |
| Backups | Implemented | Create, restore, status for all backends |
| Classification | Implemented | knn, zeroshot |
| Nodes | Implemented | Cluster node info |
| Meta | Implemented | Server version and module info |
| Auth / Well-Known | Implemented | OIDC config, liveness, readiness |
| GraphQL Get | Implemented | With search operators, filters, pagination, sort |
| GraphQL Aggregate | Not yet | Count, sum, mean, median, topOccurrences, etc. |
| GraphQL Explore | Not yet | Cross-collection vector search |
| Named Vectors | Not yet | Multiple vectors per collection (`vectorConfig`) |
| Multi-Tenancy in queries | Not yet | `tenant` parameter in Get/Aggregate |
| Tenant States | Not yet | INACTIVE, OFFLOADED states |
| RBAC / Authorization | Not yet | Role and permission management |
| New Search Operators | Not yet | nearAudio, nearVideo, nearDepth, nearThermal, nearIMU |
| Hybrid Fusion Types | Not yet | rankedFusion, relativeScoreFusion |
| ContainsAny/ContainsAll | Not yet | Array filter operators |
| Nested Properties | Not yet | object/object[] data types |
| Vector Quantization | Not yet | PQ, BQ, SQ compression |
| Generative Search (RAG) | Partial | Key exists, structured params not built out |
| Reranking | Partial | Key exists, structured params not built out |
