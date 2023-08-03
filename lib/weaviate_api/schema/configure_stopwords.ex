defmodule WeaviateApi.Schema.ConfigureStopwords do
  @moduledoc """
  Functions for configuring stopwords in the Weaviate schema.
  """

  @doc """
  Configure stopwords for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `stopwords_config` (required) - The configuration settings for the stopwords.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      stopwords_config = %{
        "remove": ["is", "the", "and"],
        "additional": ["a", "an", "in"]
      }

      {:ok, response} = WeaviateApi.Schema.ConfigureStopwords.configure_stopwords("Product", stopwords_config)
  """
  @spec configure_stopwords(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_stopwords(class_name, stopwords_config) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/stopwords-config"

    # Make the API request with the specified stopwords configuration
    api_call(:put, url, stopwords_config)
  end
end
