defmodule WeaviateApi.Schema.AddPropertyToClass do
  @moduledoc """
  Functions for adding a property to a class in the Weaviate schema.
  """

  @doc """
  Add a property to a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `property` (required) - The property to add. It should be a map with the following keys:
    - `name` (required) - The name of the property.
    - `data_type` (required) - The data type of the property.
    - `text_keyword` (optional) - The text keyword for the property.
    - `index_inverted` (optional) - Flag indicating if the property should be indexed using an inverted index.
    - `index_vector` (optional) - Flag indicating if the property should be indexed using a vector index.
    - `module_config` (optional) - Configuration settings for the property.
    - `keywords` (optional) - Additional keywords for the property.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      property = %{
        name: "description",
        data_type: "text",
        text_keyword: "description",
        index_inverted: true,
        index_vector: false,
        module_config: %{},
        keywords: ["property", "description"]
      }

      {:ok, response} = WeaviateApi.Schema.AddPropertyToClass.add_property("Product", property)
  """
  @spec add_property(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def add_property(class_name, property) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/properties"

    # Make the API request with the specified property
    api_call(:put, url, property)
  end
end
