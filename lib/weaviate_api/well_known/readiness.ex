defmodule WeaviateApi.WellKnown.Readiness do
  @moduledoc """
  Functions for checking the readiness of the Weaviate application.
  """

  @doc """
  Check if the Weaviate application is ready to receive traffic.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.WellKnown.Readiness.check_readiness()
  """
  @spec check_readiness() :: {:ok, any()} | {:error, any()}
  def check_readiness() do
    # Construct the request URL
    url = "/v1/.well-known/ready"

    # Make the API request
    api_call(:get, url)
  end
end
