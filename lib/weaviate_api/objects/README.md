# Noizu.Weaviate.Api.Objects

Noizu.Weaviate.Api.Objects is a module that provides functionality for interacting with data objects in Weaviate. With this module, you can perform CRUD operations on objects, such as creating, updating, and deleting objects.

## Preparing the Class Schema

Before performing CRUD operations on objects, you need to define the class schema using the Noizu.Weaviate.Class module. The class schema defines the structure and properties of the objects that you will be working with.

Here's an example of how to define a class schema using the Noizu.Weaviate.Class module:

```elixir
defmodule Product do
  use Noizu.Weaviate.Class

  description "A class for representing products in Weaviate"
  
  vector_index_type "hnsw"
  vector_index_config %{efConstruction: 200}

  property :name, :string, description: "The name of the product"
  property :price, :number, description: "The price of the product"
  property :description, :text, description: "The description of the product"
end
```

In this example, we define a class called "Product" using the Noizu.Weaviate.Class module. We provide a description for the class and define the vector index type and configuration. We then define the properties of the class, such as "name", "price", and "description". Each property has a name, data type, and optional description.

## CRUD Operations on Objects

Once you have defined the class schema, you can perform CRUD operations on objects of that class using the Noizu.Weaviate.Api.Objects module. Here are some examples of how to perform CRUD operations:

### Create an Object

```elixir
object = %Product{
  name: "Example Product",
  price: 9.99,
  description: "This is an example product"
}

{:ok, response} = Noizu.Weaviate.Api.Objects.create(object)
```

In this example, we create a new object of the "Product" class and assign values to its properties. We then use the `create/1` function from the `Noizu.Weaviate.Api.Objects` module to create the object in Weaviate.

### Get an Object

```elixir
class = "Product"
id = "<object_id>"

{:ok, response} = Noizu.Weaviate.Api.Objects.get(class, id)
```

In this example, we use the `get/2` function from the `Noizu.Weaviate.Api.Objects` module to get an object of the specified class with the given ID.

### Update an Object

```elixir
object = %Product{
  id: "<object_id>",
  name: "Updated Product",
  price: 19.99,
  description: "This is an updated product"
}

{:ok, response} = Noizu.Weaviate.Api.Objects.update(object)
```

In this example, we update an existing object of the "Product" class by providing the updated values for its properties. We then use the `update/1` function from the `Noizu.Weaviate.Api.Objects` module to update the object in Weaviate.

### Delete an Object

```elixir
class = "Product"
id = "<object_id>"

{:ok, response} = Noizu.Weaviate.Api.Objects.delete(class, id)
```

In this example, we use the `delete/2` function from the `Noizu.Weaviate.Api.Objects` module to delete an object of the specified class with the given ID.

These are just a few examples of what you can do with the Noizu.Weaviate.Api.Objects module. For more information, please refer to the documentation.

## Conclusion

The Noizu.Weaviate.Api.Objects module provides a convenient way to interact with data objects in Weaviate. By defining a class schema using the Noizu.Weaviate.Class module, you can perform CRUD operations on objects easily.
