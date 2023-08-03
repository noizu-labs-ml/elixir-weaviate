defmodule WeaviateApi.Meta.GetMetaInformation do
  @moduledoc """
  Functions for getting meta information about the Weaviate instance.
  """

  @doc """
  Get meta information about the Weaviate instance.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Meta.GetMetaInformation.get_meta_information()
  """
  @spec get_meta_information() :: {:ok, any()} | {:error, any()}
  def get_meta_information() do
    # Construct the request URL
    url = "/v1/meta"

    # Make the API request
    api_call(:get, url)
  end
end
