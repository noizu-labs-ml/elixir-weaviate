README.md for Noizu.Weaviate.Api.Schema
===================================

Noizu.Weaviate.Api.Schema is a module that provides functionality for interacting with the Weaviate schema API. This module offers various functions for configuring classes, properties, vector indices, inverted index, stopwords, and replication in the Weaviate schema.

## Usage

To use this module, you need to call the respective function with the required parameters.

### Defining Schema Classes

You can define schema classes using the `Noizu.Weaviate.Class` module. The `Noizu.Weaviate.Class` macro provides a convenient way to define classes and their properties. Here's an example of how to define a class:

```elixir
defmodule Product do
  use Noizu.Weaviate.Class
  weaviate_class("Product") do
      description "A class for representing products in Weaviate"
    
      property :name, :string, description: "The name of the product"
      property :price, :number, description: "The price of the product"
      property :category, :string, description: "The category of the product"
  end
end
```

In the example above, we defined a class named `Product` with three properties: `name`, `price`, and `category`. Each property has a data type and an optional description.

### Class Configuration

Once you have defined your classes, you can use the `Noizu.Weaviate.Api.Schema.Class` module to configure and interact with the classes. Here are some examples of class configuration operations:

```elixir
# Create a new class
{:ok, response} = Noizu.Weaviate.Api.Schema.Class.create(Product)

# Get information about a class
{:ok, response} = Noizu.Weaviate.Api.Schema.Class.get(Product)

# Update an existing class
{:ok, response} = Noizu.Weaviate.Api.Schema.Class.update(Product)

# Delete a class
{:ok, response} = Noizu.Weaviate.Api.Schema.Class.delete(Product)
```

These examples demonstrate how to create, get, update, and delete classes in Weaviate using the `Noizu.Weaviate.Api.Schema.Class` module.

For more details on available class configuration options, please refer to the [Weaviate API documentation](https://www.semi.technology/developers/weaviate/current/api-reference.html#tag/schemas/paths/~1schema~1classes/post).

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or a pull request on the [GitHub repository](https://github.com/noizu-weaviate/noizu_weaviate).
