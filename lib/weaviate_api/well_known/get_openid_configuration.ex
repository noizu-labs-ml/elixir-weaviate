defmodule WeaviateApi.WellKnown.GetOpenIDConfiguration do
  @moduledoc """
  Functions for getting the OpenID configuration in Weaviate.
  """

  @doc """
  Get the OpenID configuration in Weaviate.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.WellKnown.GetOpenIDConfiguration.get_openid_configuration()
  """
  @spec get_openid_configuration() :: {:ok, any()} | {:error, any()}
  def get_openid_configuration() do
    # Construct the request URL
    url = "/v1/.well-known/openid-configuration"

    # Make the API request
    api_call(:get, url)
  end
end
