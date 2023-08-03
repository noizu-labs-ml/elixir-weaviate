defmodule WeaviateApi.Schema.ConfigureClass do
  @moduledoc """
  Module for configuring a class in Weaviate.
  """

  @doc """
  Create or update a class.

  ## Parameters

  - `class_name` - The name of the class.
  - `class_config` - The configuration settings for the class.

  ## Example

      class_name = "Person"
      class_config = %{
        c: class_name,
        d: "A class for representing people in Weaviate",
        ...
      }
      WeaviateApi.Schema.configure_class(class_name, class_config)
  """
  @spec configure_class(String.t, map()) :: {:ok, map()} | {:error, map()}
  def configure_class(class_name, class_config) do
    url = "/v1/schema/#{class_name}"
    WeaviateApi.request(:put, url, class_config)
  end
end
