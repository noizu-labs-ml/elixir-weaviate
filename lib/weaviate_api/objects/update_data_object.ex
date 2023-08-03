defmodule WeaviateApi.Objects.UpdateDataObject do
  @moduledoc """
  Functions for updating a data object in Weaviate.
  """

  @doc """
  Update a data object in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class that the data object belongs to.
  - `id` (required) - The ID of the data object.
  - `properties` (required) - The updated property values of the data object.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      properties = [
        %{"name" => "John Doe"},
        %{"age" => 30}
      ]

      {:ok, response} = WeaviateApi.Objects.UpdateDataObject.update_data_object("Person", "12345678-1234-1234-1234-1234567890ab", properties)
  """
  @spec update_data_object(String.t(), String.t(), [map()]) :: {:ok, any()} | {:error, any()}
  def update_data_object(class_name, id, properties) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}"

    # Construct the request body
    body = %{properties: properties}

    # Make the API request with the specified parameters
    api_call(:put, url, body)
  end
end
