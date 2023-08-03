defmodule WeaviateApi.Classification.GetClassificationStatus do
  @moduledoc """
  Functions for getting the status, results, and metadata of a classification in Weaviate.
  """

  @doc """
  Get the status, results, and metadata of a classification in Weaviate.

  ## Parameters

  - `classification_id` (required) - The ID of the classification.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      classification_id = "123456789"

      {:ok, response} = WeaviateApi.Classification.GetClassificationStatus.get_classification_status(classification_id)
  """
  @spec get_classification_status(String.t()) :: {:ok, any()} | {:error, any()}
  def get_classification_status(classification_id) do
    # Construct the request URL
    url = "/v1/classifications/#{classification_id}"

    # Make the API request
    api_call(:get, url)
  end
end
