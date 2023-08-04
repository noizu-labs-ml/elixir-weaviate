defmodule Noizu.Weaviate.Api.Auth do
  @moduledoc """
  Functions for authentication in the Weaviate API.
  """

  alias Noizu.Weaviate
  require Noizu.Weaviate
  import Noizu.Weaviate


  # -------------------------------
  #
  # -------------------------------
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

  # -------------------------------
  #
  # -------------------------------
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

  # -------------------------------
  #
  # -------------------------------
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
