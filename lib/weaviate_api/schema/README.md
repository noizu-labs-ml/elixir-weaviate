# Noizu.Weaviate.Api.Schema

`Noizu.Weaviate.Api.Schema` is a module that provides functions for interacting with the Weaviate schema API. This module allows you to create or update classes, configure properties, configure indices, and perform other schema-related operations in Weaviate.

## Functions

### configure_class(class_name, class_config)

Create or update a class in the Weaviate schema.

Parameters:
- `class_name` (required) - The name of the class.
- `class_config` (required) - The configuration settings for the class.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

Example:

```elixir
class_name = "Person"
class_config = %{
  c: class_name,
  d: "A class for representing people in Weaviate",
  ...
}
{:ok, response} = Noizu.Weaviate.Api.Schema.configure_class(class_name, class_config)
```

### add_property(class_name, property)

Add a property to a class in the Weaviate schema.

Parameters:
- `class_name` (required) - The name of the class.
- `property` (required) - The property to add, specified as a map with the necessary keys such as `name`, `data_type`, etc.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

Example:

```elixir
class_name = "Product"
property = %{
  name: "description",
  data_type: "text",
  text_keyword: "description",
  index_inverted: true,
  index_vector: false,
  module_config: %{},
  keywords: ["property", "description"]
}
{:ok, response} = Noizu.Weaviate.Api.Schema.add_property(class_name, property)
```

### configure_property(class_name, property_name, property_config)

Configure a property of a class in the Weaviate schema.

Parameters:
- `class_name` (required) - The name of the class.
- `property_name` (required) - The name of the property to configure.
- `property_config` (required) - The configuration settings for the property.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

Example:

```elixir
class_name = "Product"
property_name = "name"
property_config = %{
  "dataType": "string",
  "description": "The name of the product",
  "moduleConfig": %{}
}
{:ok, response} = Noizu.Weaviate.Api.Schema.configure_property(class_name, property_name, property_config)
```

### configure_vector_indices(class_name, vector_indices)

Configure vector indices for a class in the Weaviate schema.

Parameters:
- `class_name` (required) - The name of the class.
- `vector_indices` (required) - The configuration settings for the vector indices.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

Example:

```elixir
class_name = "Product"
vector_indices = %{
  "indexType": "hnsw"
}
{:ok, response} = Noizu.Weaviate.Api.Schema.configure_vector_indices(class_name, vector_indices)
```

### configure_inverted_index(class_name, inverted_index)

Configure inverted index for a class in the Weaviate schema.

Parameters:
- `class_name` (required) - The name of the class.
- `inverted_index` (required) - The configuration settings for the inverted index.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

Example:

```elixir
class_name = "Product"
inverted_index = %{
  "cleanupIntervalSeconds": 600,
  "maximumCleanupDurationSeconds": 1800
}
{:ok, response} = Noizu.Weaviate.Api.Schema.configure_inverted_index(class_name, inverted_index)
```

### configure_stopwords(class_name, stopwords_config)

Configure stopwords for a class in the Weaviate schema.

Parameters:
- `class_name` (required) - The name of the class.
- `stopwords_config` (required) - The configuration settings for the stopwords.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

Example:

```elixir
class_name = "Product"
stopwords_config = %{
  "remove": ["is", "the", "and"],
  "additional": ["a", "an", "in"]
}
{:ok, response} = Noizu.Weaviate.Api.Schema.configure_stopwords(class_name, stopwords_config)
```

### configure_replication(class_name, replication_config)

Configure replication in the Weaviate schema.

Parameters:
- `class_name` (required) - The name of the class.
- `replication_config` (required) - The replication configuration settings.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

Example:

```elixir
class_name = "Product"
replication_config = %{
  "f": 2
}
{:ok, response} = Noizu.Weaviate.Api.Schema.configure_replication(class_name, replication_config)
```

## Private Functions

### api_call(method, url, body)

A private function used to make the API call.

Parameters:
- `method` (required) - The HTTP method of the API call.
- `url` (required) - The URL of the API endpoint.
- `body` (optional) - The request body.

Returns:
- `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

## Prerequisites

To use the `Noizu.Weaviate.Api.Schema` module, you need to have the Weaviate API set up and running. You also need to have the necessary authentication credentials to access the API.

For more details on the Weaviate API and how to set it up, refer to the [Weaviate documentation](https://www.semi.technology/documentation/weaviate/current/).

## Installation

Add `noizu_weaviate` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:noizu_weaviate, "~> 0.1.0"}
  ]
end
```

## Usage

To use the `Noizu.Weaviate.Api.Schema` module, you need to import it and provide the necessary parameters for the API calls.

Here's an example of how you can use the module to configure a class in the Weaviate schema:

```elixir
import Noizu.Weaviate.Api.Schema

class_name = "Product"
class_config = %{
  c: class_name,
  d: "A class for representing products in Weaviate",
  ...
}

configure_class(class_name, class_config)
```

For more examples and details on the available functions, refer to the module and its documentation.
