# Noizu.Weaviate - README

Noizu.Weaviate is a library providing a simple wrapper around Weaviate's API calls. With Noizu.Weaviate, you can easily interact with Weaviate's schema and objects.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
    - [Defining Schema Classes](#defining-schema-classes)
    - [Creating Objects](#creating-objects)
    - [Editing Objects](#editing-objects)
    - [Deleting Objects](#deleting-objects)
- [API Modules](#api-modules)
    - [Noizu.Weaviate.Api.Meta](#noizoweaviateapimeta)
    - [Noizu.Weaviate.Api.Batch](#noizoweaviateapibatch)
    - [Noizu.Weaviate.Api.Backups](#noizoweaviateapibackups)
    - [Noizu.Weaviate.Api.Schema](#noizoweaviateapischema)
    - [Noizu.Weaviate.Api.Nodes](#noizoweaviateapinodes)
    - [Noizu.Weaviate.Api.Objects](#noizoweaviateapiobjects)
    - [Noizu.Weaviate.Api.Auth](#noizoweaviateapiauth)
    - [Noizu.Weaviate.Api.Classification](#noizoweaviateapiclassification)

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

  description "A class for representing products in Weaviate"

  property :name, :string
  property :price, :number
  property :description, :text
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
