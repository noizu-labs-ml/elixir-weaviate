defmodule Noizu.Weaviate.Api.Meta do
  @moduledoc """
  Functions for getting meta information about the Weaviate instance.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  #-------------------------------
  #
  #-------------------------------
  @doc """
  Get meta information about the Weaviate instance.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Meta.get_meta_information()
  """
  @spec get_meta_information() :: {:ok, any()} | {:error, any()}
  def get_meta_information() do
    url = weaviate_base() <> "meta"

    api_call(:get, url, nil, :json, nil)
  end
end
