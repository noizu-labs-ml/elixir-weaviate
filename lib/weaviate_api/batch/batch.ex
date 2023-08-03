defmodule Noizu.Weaviate.Api.Batch do
  @moduledoc """
  Functions for batch operations in Weaviate.
  """

  @doc """
  Batch create objects in Weaviate.

  ## Parameters

  - `objects` (required) - The list of objects to be created. Each object should be a map representing the object properties.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      object1 = %{
        "class": "Product",
        "properties": [
          %{"name": "title", "dataType": "string", "valueString": "Product 1"},
          %{
            "name": "price",
            "dataType": "number",
            "valueNumber": 10.99
          }
        ]
      }

      object2 = %{
        "class": "Product",
        "properties": [
          %{"name": "title", "dataType": "string", "valueString": "Product 2"},
          %{
            "name": "price",
            "dataType": "number",
            "valueNumber": 13.99
          }
        ]
      }

      objects = [object1, object2]

      {:ok, response} = Noizu.Weaviate.Api.Batch.batch_create_objects(objects)
  """
  @spec batch_create_objects([map()]) :: {:ok, any()} | {:error, any()}
  def batch_create_objects(objects) do
    # Construct the request URL
    url = "/v1/batch/objects"

    # Construct the request body
    body = %{objects: objects}

    # Make the API request to batch create the objects
    api_call(:post, url, body)
  end

  @doc """
  Batch create references in Weaviate.

  ## Parameters

  - `references` (required) - The list of references to be created. Each reference should be a map with `from` and `to` properties representing the source and target objects.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

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
  """
  @spec batch_create_references([map()]) :: {:ok, any()} | {:error, any()}
  def batch_create_references(references) do
    # Construct the request URL
    url = "/v1/batch/references"

    # Construct the request body
    body = %{references: references}

    # Make the API request to batch create the references
    api_call(:post, url, body)
  end

  @doc """
  Batch delete objects in Weaviate.

  ## Parameters

  - `match` (required) - An object outlining how to identify the objects to be deleted. It should have the following keys:
    - `class` (required) - The class name as defined in the schema.
    - `where` (required) - The where filter object to find the objects to be deleted.
  - `output` (optional) - The verbosity level (`"minimal"` or `"verbose"`). Defaults to `"minimal"`.
  - `dry_run` (optional) - If true, objects will not be deleted yet, but merely listed. Defaults to false.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      match = %{
        "class": "Product",
        "where": %{"name": {"equals": "Product 1"}}
      }

      {:ok, response} = Noizu.Weaviate.Api.Batch.batch_delete_objects(match)
  """
  @spec batch_delete_objects(map(), String.t(), boolean()) :: {:ok, any()} | {:error, any()}
  def batch_delete_objects(match, output \\ "minimal", dry_run \\ false) do
    # Construct the request URL
    url = "/v1/batch/objects"

    # Construct the request body
    body = %{
      match: match,
      output: output,
      dryRun: dry_run
    }

    # Make the API request to batch delete the objects
    api_call(:delete, url, body)
  end
end
