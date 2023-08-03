defmodule Noizu.WeaviateApi.Auth do
  @moduledoc """
  Functions for authentication in the Weaviate API.
  """

  @doc """
  Makes an API call to the Weaviate endpoint with the given method and URL.

  ## Parameters

  - `method` (atom): The HTTP method for the API call, e.g. :get, :post, :put, :delete.
  - `url` (string): The URL endpoint for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.WeaviateApi.Auth.api_call(:get, "/v1/.well-known/openid-configuration")
  """
  @spec api_call(atom, String.t()) :: {:ok, any()} | {:error, any()}
  def api_call(method, url) do
    # Make the API request
    # ...
  end

  @moduledoc """
  Functions for getting the OpenID configuration in Weaviate.
  """

  @doc """
  Get the OpenID configuration in Weaviate.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.WeaviateApi.Auth.get_openid_configuration()
  """
  @spec get_openid_configuration() :: {:ok, any()} | {:error, any()}
  def get_openid_configuration() do
    # Construct the request URL
    url = "/v1/.well-known/openid-configuration"

    # Make the API request
    api_call(:get, url)
  end

  @moduledoc """
  Functions for checking the liveness of the Weaviate application.
  """

  @doc """
  Check if the Weaviate application is alive.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.WeaviateApi.Auth.check_liveness()
  """
  @spec check_liveness() :: {:ok, any()} | {:error, any()}
  def check_liveness() do
    # Construct the request URL
    url = "/v1/.well-known/live"

    # Make the API request
    api_call(:get, url)
  end

  @moduledoc """
  Functions for checking the readiness of the Weaviate application.
  """

  @doc """
  Check if the Weaviate application is ready to receive traffic.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.WeaviateApi.Auth.check_readiness()
  """
  @spec check_readiness() :: {:ok, any()} | {:error, any()}
  def check_readiness() do
    # Construct the request URL
    url = "/v1/.well-known/ready"

    # Make the API request
    api_call(:get, url)
  end
end