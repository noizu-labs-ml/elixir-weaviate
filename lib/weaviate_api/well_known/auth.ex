defmodule Noizu.Weaviate.Api.Auth do
  @moduledoc """
  Functions for authentication in the Weaviate API.
  """

  alias Noizu.Weaviate
  require Noizu.Weaviate
  import Noizu.Weaviate
  #-------------------------------
  #
  #-------------------------------
  @doc """
  Makes an API call to the Weaviate endpoint with the given method and URL.

  ## Parameters

  - `method` (atom): The HTTP method for the API call, e.g. :get, :post, :put, :delete.
  - `url` (string): The URL endpoint for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Auth.api_call(:get, "/v1/.well-known/openid-configuration")
  """
  @spec api_call(atom, String.t(), term, term, options) :: {:ok, any()} | {:error, any()}
  def api_call(method, url, body, response_type, options) do
    api_call(method, url, body, response_type, :json, options)
  end

  #-------------------------------
  #
  #-------------------------------
  @doc """
  Get the OpenID configuration in Weaviate.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Auth.get_openid_configuration()
  """
  @spec get_openid_configuration(options :: any) :: {:ok, any()} | {:error, any()}
  def get_openid_configuration(options \\ nil) do
    # Construct the request URL
    url = Weaviate.weaviate_base() <> "/.well-known/openid-configuration"

    # Make the API request
    api_call(:get, url, nil, WeaviateStructs.OpenIDConfiguration, options)
  end

  #-------------------------------
  #
  #-------------------------------
  @doc """
  Check if the Weaviate application is alive.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Auth.check_liveness()
  """
  @spec check_liveness(options :: any) :: {:ok, any()} | {:error, any()}
  def check_liveness(options \\ nil) do
    # Construct the request URL
    url = Weaviate.weaviate_base() <> "/.well-known/live"

    # Make the API request
    api_call(:get, url, nil, {}, options)
  end

  #-------------------------------
  #
  #-------------------------------
  @doc """
  Check if the Weaviate application is ready to receive traffic.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Auth.check_readiness()
  """
  @spec check_readiness(options :: any) :: {:ok, any()} | {:error, any()}
  def check_readiness(options \\ nil) do
    # Construct the request URL
    url = Weaviate.weaviate_base() <> "/.well-known/ready"

    # Make the API request
    api_call(:get, url, nil, {}, options)
  end
end
