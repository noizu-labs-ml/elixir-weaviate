defmodule Noizu.Weaviate.Api.Nodes do
  @moduledoc """
  Functions for getting information about the Weaviate nodes.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  @doc """
  Get information about the Weaviate nodes.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Nodes.get_information_about_nodes()
  """
  @spec get_information_about_nodes() :: {:ok, any()} | {:error, any()}
  def get_information_about_nodes() do
    url = "#{Noizu.Weaviate.weaviate_base()}nodes"

    Noizu.Weaviate.api_call(:get, url, nil, :json,  nil)
  end
end
