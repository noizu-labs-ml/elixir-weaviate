defmodule WeaviateApi.Schema.ConfigureInvertedIndex do
  @moduledoc """
  Functions for configuring inverted index in the Weaviate schema.
  """

  @doc """
  Configure inverted index for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `inverted_index` (required) - The configuration settings for the inverted index.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      inverted_index = %{
        "cleanupIntervalSeconds": 600,
        "maximumCleanupDurationSeconds": 1800
      }

      {:ok, response} = WeaviateApi.Schema.ConfigureInvertedIndex.configure_inverted_index("Product", inverted_index)
  """
  @spec configure_inverted_index(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_inverted_index(class_name, inverted_index) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/inverted-index-config"

    # Make the API request with the specified inverted index configuration
    api_call(:put, url, inverted_index)
  end
end
