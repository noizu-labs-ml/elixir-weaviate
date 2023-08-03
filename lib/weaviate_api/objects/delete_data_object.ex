defmodule WeaviateApi.Objects.DeleteDataObject do
  @moduledoc """
  Functions for deleting a data object in Weaviate.
  """

  @doc """
  Delete a data object in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class that the data object belongs to.
  - `id` (required) - The ID of the data object.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.DeleteDataObject.delete_data_object("Person", "12345678-1234-1234-1234-1234567890ab")
  """
  @spec delete_data_object(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def delete_data_object(class_name, id) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}"

    # Make the API request with the specified parameters
    api_call(:delete, url)
  end
end
