defmodule WeaviateApi.WellKnown.Liveness do
  @moduledoc """
  Functions for checking the liveness of the Weaviate application.
  """

  @doc """
  Check if the Weaviate application is alive.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.WellKnown.Liveness.check_liveness()
  """
  @spec check_liveness() :: {:ok, any()} | {:error, any()}
  def check_liveness() do
    # Construct the request URL
    url = "/v1/.well-known/live"

    # Make the API request
    api_call(:get, url)
  end
end
