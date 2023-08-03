defmodule WeaviateApi.Batch.BatchCreateReferences do
  @moduledoc """
  Functions for batch creating references in Weaviate.
  """

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

      {:ok, response} = WeaviateApi.Batch.BatchCreateReferences.batch_create(references)
  """
  @spec batch_create([map()]) :: {:ok, any()} | {:error, any()}
  def batch_create(references) do
    # Construct the request URL
    url = "/v1/batch/references"

    # Construct the request body
    body = %{references: references}

    # Make the API request to batch create the references
    api_call(:post, url, body)
  end
end
