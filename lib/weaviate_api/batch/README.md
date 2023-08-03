# Noizu.Weaviate.Api.Batch

`Noizu.Weaviate.Api.Batch` is a module that provides functions for batch operations in Weaviate. These operations allow you to perform multiple actions at once, such as creating or deleting multiple objects or creating multiple references.

## Batch Create Objects

The `batch_create_objects/1` function allows you to batch create objects in Weaviate.

### Parameters

- `objects` (required): A list of objects to be created. Each object should be a map representing the object properties.

### Returns

- A tuple `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

### Examples

```elixir
object1 = %{
  "class": "Product",
  "properties": [
    %{"name": "title", "dataType": "string", "valueString": "Product 1"},
    %{"name": "price", "dataType": "number", "valueNumber": 10.99}
  ]
}

object2 = %{
  "class": "Product",
  "properties": [
    %{"name": "title", "dataType": "string", "valueString": "Product 2"},
    %{"name": "price", "dataType": "number", "valueNumber": 13.99}
  ]
}

objects = [object1, object2]

{:ok, response} = Noizu.Weaviate.Api.Batch.batch_create_objects(objects)
```

## Batch Create References

The `batch_create_references/1` function allows you to batch create references in Weaviate.

### Parameters

- `references` (required): A list of references to be created. Each reference should be a map with `from` and `to` properties representing the source and target objects.

### Returns

- A tuple `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

### Examples

```elixir
reference1 = %{
  "from": "weaviate://localhost/Product/1234",
  "to": "weaviate://localhost/Product/5678"
}

reference2 = %{
  "from": "weaviate://localhost/Product/1234",
  "to": "weaviate://localhost/Product/7890"
}

references = [reference1, reference2]

{:ok, response} = Noizu.Weaviate.Api.Batch.batch_create_references(references)
```

## Batch Delete Objects

The `batch_delete_objects/1` function allows you to batch delete objects in Weaviate.

### Parameters

- `match` (required): An object outlining how to identify the objects to be deleted. It should have the following keys:
    - `class` (required): The class name as defined in the schema.
    - `where` (required): The where filter object to find the objects to be deleted.
- `output` (optional): The verbosity level (`"minimal"` or `"verbose"`). Defaults to `"minimal"`.
- `dry_run` (optional): If true, objects will not be deleted yet, but merely listed. Defaults to false.

### Returns

- A tuple `{:ok, response}` on successful API call, where `response` is the API response.
- `{:error, term}` on failure, where `term` contains error details.

### Examples

```elixir
match = %{
  "class": "Product",
  "where": %{"name": {"equals": "Product 1"}}
}

{:ok, response} = Noizu.Weaviate.Api.Batch.batch_delete_objects(match)
```

For more details on the `Noizu.Weaviate.Api.Batch` module and its functions, refer to the source code and documentation.
