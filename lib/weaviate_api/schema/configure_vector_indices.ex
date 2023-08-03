defmodule WeaviateApi.Schema.ConfigureVectorIndices do
  @moduledoc """
  Functions for configuring vector indices in the Weaviate schema.
  """

  @doc """
  Configure vector indices for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `vector_indices` (required) - The configuration settings for the vector indices.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      vector_indices = %{
        "indexType": "hnsw"
      }

      {:ok, response} = WeaviateApi.Schema.ConfigureVectorIndices.configure_vector_indices("Product", vector_indices)
  """
  @spec configure_vector_indices(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_vector_indices(class_name, vector_indices) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/vector-index-config"

    # Make the API request with the specified vector indices configuration
    api_call(:put, url, vector_indices)
  end
end
