defmodule WeaviateApi.Batch.BatchDeleteObjects do
  @moduledoc """
  Functions for batch deleting objects in Weaviate.
  """

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

      {:ok, response} = WeaviateApi.Batch.BatchDeleteObjects.batch_delete(match)
  """
  @spec batch_delete(map(), String.t(), boolean()) :: {:ok, any()} | {:error, any()}
  def batch_delete(match, output \\ "minimal", dry_run \\ false) do
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
