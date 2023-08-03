defmodule WeaviateApi.Objects.CreateDataObject do
  @moduledoc """
  Functions for creating a data object in Weaviate.
  """

  @doc """
  Create a new data object in Weaviate.

  ## Parameters

  - `class_name` (required) - The class name as defined in the schema.
  - `properties` (required) - An object with the property values of the new data object.
  - `id` (optional) - An optional ID for the object.
  - `vector` (optional) - An optional custom vector.
  - `tenant` (optional) - An optional tenant name.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      properties = %{name: "Apple", color: "Red"}
      {:ok, response} = WeaviateApi.Objects.CreateDataObject.create_data_object("Product", properties)
  """
  @spec create_data_object(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def create_data_object(class_name, properties) do
    # Construct the request URL
    url = "/v1/objects"

    # Build the data object parameters
    data_object = %{class: class_name, properties: properties}

    # Make the API request with the specified data object
    api_call(:post, url, data_object)
  end
end
