defmodule Noizu.Weaviate.Api.Cluster do
  @moduledoc """
  Functions for interacting with the Weaviate cluster API.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  @doc """
  Get cluster statistics.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Cluster.get_statistics()
  """
  @spec get_statistics(options :: any) :: {:ok, any()} | {:error, any()}
  # ⟦𓌬𓂮𓎽𓌘⟧ get_statistics :: Get cluster statistics.
  def get_statistics(options \\ nil) do
    url = api_base() <> "v1/cluster/statistics"
    api_call(:get, url, nil, :json, options)
  end
end
