defmodule WeaviateApi.Batch.BatchCreateObjects do
  @moduledoc """
  Functions for batch creating objects in Weaviate.
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

      {:ok, response} = WeaviateApi.Batch.BatchCreateObjects.batch_create(objects)
  """
  @spec batch_create([map()]) :: {:ok, any()} | {:error, any()}
  def batch_create(objects) do
    # Construct the request URL
    url = "/v1/batch/objects"

    # Construct the request body
    body = %{objects: objects}

    # Make the API request to batch create the objects
    api_call(:post, url, body)
  end
end
