# Noizu.Weaviate.Api.Objects

`Noizu.Weaviate.Api.Objects` is a module that provides functions for interacting with data objects in Weaviate. Weaviate is a knowledge graph that allows you to easily store, search, and use data objects in a semantic and structured way.

## Add a cross-reference to a data object

The `add_cross_reference/4` function adds a cross-reference to a data object in Weaviate.

### Parameters

- `class_name` class that the data object belongs to.
- `id` (required): The ID of the data object.
- `property_name` (required): The name of the property to add the cross-reference to.
- `beacon` (required): The beacon URL of the reference, in the format `weaviate://localhost/<ClassName>/<id>`.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
{:ok, response} = Noizu.Weaviate.Api.Objects.add_cross_reference("Person", "12345678-1234-1234-1234-1234567890ab", "friends", "weaviate://localhost/Person/87654321-4321-4321-4321-210987654321")
```

## Check if a data object exists

The `check_if_data_object_exists/2` function checks if a data object exists in Weaviate.

### Parameters

- `class_name` (required): The name of the class that the data object belongs to.
- `id` (required): The ID of the data object.

### Returns

A tuple `{:ok, exists}` on successful API call, where `exists` is a boolean indicating if the data object exists.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
{:ok, exists} = Noizu.Weaviate.Api.Objects.check_if_data_object_exists("Product", "12345678-1234-1234-1234-1234567890ab")
```

## Create a new data object

The `create_data_object/2` function creates a new data object in Weaviate.

### Parameters

- `class_name` (required): The class name as defined in the schema.
- `properties` (required): An object with the property values of the new data object.
- `id` (optional): An optional ID for the object.
- `vector` (optional): An optional custom vector.
- `tenant` (optional): An optional tenant name.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
properties = %{name: "Apple", color: "Red"}
{:ok, response} = Noizu.Weaviate.Api.Objects.create_data_object("Product", properties)
```

## Delete a cross-reference

The `delete_cross_reference/4` function deletes a cross-reference in Weaviate.

### Parameters

- `class_name` (required): The name of the class of the source object.
- `id` (required): The ID of the source object.
- `property_name` (required): The name of the property containing the cross-reference.
- `beacon` (required): The beacon URL of the reference to delete, in the format "weaviate://localhost/<ClassName>/<id>".

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
{:ok, response} = Noizu.Weaviate.Api.Objects.delete_cross_reference("Product", "1234", "relatedProducts", "weaviate://localhost/Product/5678")
```

## Delete a data object

The `delete_data_object/2` function deletes a data object in Weaviate.

### Parameters

- `class_name` (required): The name of the class that the data object belongs to.
- `id` (required): The ID of the data object.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
{:ok, response} = Noizu.Weaviate.Api.Objects.delete_data_object("Person", "12345678-1234-1234-1234-1234567890ab")
```

## Get a data object

The `get_data_object/2` function gets a data object in Weaviate by ID.

### Parameters

- `class_name` (required): The class name of the data object.
- `id` (required): The ID of the data object to fetch.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
{:ok, response} = Noizu.Weaviate.Api.Objects.get_data_object("Product", "1234-abcd-5678-efgh")
```

## List data objects

The `list_data_objects/1` function lists data objects in Weaviate.

### Parameters

- `opts` (optional): A map with options for filtering, pagination, and sorting the list of data objects.
  - `class` (optional): The class name to filter the data objects by.
  - `limit` (optional): The maximum number of data objects to return. Default is 25.
  - `offset` (optional): The offset of data objects returned (the starting index of the returned objects). Cannot be used with `after`. Should be used in conjunction with `limit`.
  - `after` (optional): The ID of the object after which (i.e. non-inclusive ID) objects are to be listed. Must be used with `class`. Cannot be used with `offset` or `sort`. Should be used in conjunction with `limit`.
  - `include` (optional): Additional information to include, such as classification info. Allowed values include: classification, vector, featureProjection, and other module-specific additional properties.
  - `sort` (optional): Name of the property to sort by. You can also provide multiple names separated by commas.
  - `order` (optional): Order in which to sort by. Possible values are "asc" (default) and "desc". Should be used in conjunction with `sort`.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
{:ok, response} = Noizu.Weaviate.Api.Objects.list_data_objects()
{:ok, response} = Noizu.Weaviate.Api.Objects.list_data_objects(class: "Product", limit: 10)
```

## Update a cross-reference

The `update_cross_reference/4` function updates a cross-reference in Weaviate.

### Parameters

- `class_name` (required): The name of the class of the source object.
- `id` (required): The ID of the source object.
- `property_name` (required): The name of the property containing the cross-reference.
- `beacon` (required): The beacon URL of the reference, in the format "weaviate://localhost/<ClassName>/<id>".

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
{:ok, response} = Noizu.Weaviate.Api.Objects.update_cross_reference("Product", "1234", "relatedProducts", "weaviate://localhost/Product/5678")
```

## Update a data object

The `update_data_object/3` function updates a data object in Weaviate.

### Parameters

- `class_name` (required): The name of the class that the data object belongs to.
- `id` (required): The ID of the data object.
- `properties` (required): The updated property values of the data object.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
properties = [
  %{"name" => "John Doe"},
  %{"age" => 30}
]

{:ok, response} = Noizu.Weaviate.Api.Objects.update_data_object("Person", "12345678-1234-1234-1234-1234567890ab", properties)
```

## Validate a data object

The `validate_data_object/3` function validates a data object in Weaviate.

### Parameters

- `class_name` (required): The name of the class that the data object belongs to.
- `properties` (required): The property values of the data object to be validated.
- `id` (optional): The ID of the data object.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Example

```elixir
properties = [
  %{"name" => "John Doe"},
  %{"age" => 30}
]

{:ok, response} = Noizu.Weaviate.Api.Objects.validate_data_object("Person", properties)
```

For more details on the `Noizu.Weaviate.Api.Objects` module and its functions, refer to the source code and documentation and the [https://weaviate.io/developers/weaviate/manage-data/classes](weaviate documentation).
