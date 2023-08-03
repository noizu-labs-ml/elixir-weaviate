defmodule WeaviateApi.Objects.ValidateDataObject do
  @moduledoc """
  Functions for validating a data object in Weaviate.
  """

  @doc """
  Validate a data object in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class that the data object belongs to.
  - `properties` (required) - The property values of the data object to be validated.
  - `id` (optional) - The ID of the data object.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      properties = [
        %{"name" => "John Doe"},
        %{"age" => 30}
      ]

      {:ok, response} = WeaviateApi.Objects.ValidateDataObject.validate_data_object("Person", properties)
  """
  @spec validate_data_object(String.t(), [map()], String.t()) :: {:ok, any()} | {:error, any()}
  def validate_data_object(class_name, properties, id \\ "") do
    # Construct the request URL
    url = "/v1/objects/validate"

    # Construct the request body
    body = %{
      class: class_name,
      properties: properties,
      id: id
    }

    # Make the API request with the specified parameters
    api_call(:post, url, body)
  end
end
