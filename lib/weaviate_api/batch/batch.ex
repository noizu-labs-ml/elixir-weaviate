defmodule Noizu.Weaviate.Api.Batch do
  @moduledoc """
  Functions for batch operations in Weaviate.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  # -------------------------------
  # Batch create objects
  # -------------------------------

  @doc """
  Batch create objects in Weaviate.

  ## Parameters

  - `objects` (required) - The list of objects to be created. Each object should be a map representing the object properties.
  - `options` (optional) - Additional options for the API call.

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

      {:ok, response} = Noizu.Weaviate.Api.Batch.create_objects(objects)
  """
  @spec create_objects([map()], options() \\ nil) ::
          {:ok, WeaviateStructs.RespObj} | {:error, any()}
  def create_objects(objects, options \\ nil) do
    # Construct the request URL
    url = "/v1/batch/objects"

    # Construct the request body
    body = %{objects: objects}

    # Make the API request to batch create the objects
    Noizu.Weaviate.api_call(:post, url, body, WeaviateStructs.RespObj, options)
  end

  # -------------------------------
  # Batch create references
  # -------------------------------

  @doc """
  Batch create references in Weaviate.

  ## Parameters

  - `references` (required) - The list of references to be created. Each reference should be a map with `from` and `to` properties representing the source and target objects.
  - `options` (optional) - Additional options for the API call.

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

      {:ok, response} = Noizu.Weaviate.Api.Batch.create_references(references)
  """
  @spec create_references([map()], options() \\ nil) ::
          {:ok, WeaviateStructs.RespObj} | {:error, any()}
  def create_references(references, options \\ nil) do
    # Construct the request URL
    url = "/v1/batch/references"

    # Construct the request body
    body = %{references: references}

    # Make the API request to batch create the references
    Noizu.Weaviate.api_call(:post, url, body, WeaviateStructs.RespObj, options)
  end

  # -------------------------------
  # Batch delete objects
  # -------------------------------

  @doc """
  Batch delete objects in Weaviate.

  ## Parameters

  - `match` (required) - An object outlining how to identify the objects to be deleted. It should have the following keys:
    - `class` (required) - The class name as defined in the schema.
    - `where` (required) - The where filter object to find the objects to be deleted.
  - `output` (optional) - The verbosity level (`"minimal"` or `"verbose"`). Defaults to `"minimal"`.
  - `dry_run` (optional) - If true, objects will not be deleted yet, but merely listed. Defaults to false.
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      match = %{
        "class": "Product",
        "where": %{"name": {"equals": "Product 1"}}
      }

      {:ok, response} = Noizu.Weaviate.Api.Batch.delete_objects(match)
  """
  @spec delete_objects(map(), options() \\ nil) ::
          {:ok, WeaviateStructs.RespObj} | {:error, any()}
  def delete_objects(match, options \\ nil) do
    # Construct the request URL
    url = "/v1/batch/objects"

    # Construct the request body
    body = %{
      match: match,
      output: "minimal",
      dryRun: false
    }

    # Make the API request to batch delete the objects
    Noizu.Weaviate.api_call(:delete, url, body, WeaviateStructs.RespObj, options)
  end
end
