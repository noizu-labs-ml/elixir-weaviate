defmodule WeaviateApi.Schema.ConfigureReplication do
  @moduledoc """
  Functions for configuring replication in the Weaviate schema.
  """

  @doc """
  Configure replication in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `replication_config` (required) - The replication configuration settings.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      replication_config = %{
        "f": 2
      }

      {:ok, response} = WeaviateApi.Schema.ConfigureReplication.configure_replication("Product", replication_config)
  """
  @spec configure_replication(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_replication(class_name, replication_config) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/replication-config"

    # Make the API request with the specified replication configuration
    api_call(:put, url, replication_config)
  end
end
