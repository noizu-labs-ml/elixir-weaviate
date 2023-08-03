defmodule Noizu.Weaviate.Api.Nodes do
  @moduledoc """
  Functions for getting information about the Weaviate nodes.
  """

  @doc """
  Get information about the Weaviate nodes.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Nodes.GetInformationAboutNodes.get_information_about_nodes()
  """
  @spec get_information_about_nodes() :: {:ok, any()} | {:error, any()}
  def get_information_about_nodes() do
    # Construct the request URL
    url = "/v1/nodes"

    # Make the API request
    api_call(:get, url)
  end
end
