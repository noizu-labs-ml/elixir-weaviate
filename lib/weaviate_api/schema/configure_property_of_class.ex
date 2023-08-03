defmodule WeaviateApi.Schema.ConfigurePropertyOfClass do
  @moduledoc """
  Functions for configuring a property of a class in the Weaviate schema.
  """

  @doc """
  Configure a property of a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `property_name` (required) - The name of the property to configure.
  - `property_config` (required) - The configuration settings for the property.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      property_config = %{
        "dataType": "string",
        "description": "The name of the product",
        "moduleConfig": %{}
      }

      {:ok, response} = WeaviateApi.Schema.ConfigurePropertyOfClass.configure_property("Product", "name", property_config)
  """
  @spec configure_property(String.t(), String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_property(class_name, property_name, property_config) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/properties/#{property_name}"

    # Make the API request with the specified property configuration
    api_call(:put, url, property_config)
  end
end
