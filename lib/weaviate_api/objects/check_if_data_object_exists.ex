defmodule WeaviateApi.Objects.CheckIfDataObjectExists do
  @moduledoc """
  Functions for checking if a data object exists in Weaviate.
  """

  @doc """
  Check if a data object exists in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class that the data object belongs to.
  - `id` (required) - The ID of the data object.

  ## Returns

  A tuple `{:ok, exists}` on successful API call, where `exists` is a boolean indicating if the data object exists.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, exists} = WeaviateApi.Objects.CheckIfDataObjectExists.check_if_data_object_exists("Product", "12345678-1234-1234-1234-1234567890ab")
  """
  @spec check_if_data_object_exists(String.t(), String.t()) :: {:ok, boolean()} | {:error, any()}
  def check_if_data_object_exists(class_name, id) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}"

    # Make the API request with the specified parameters
    api_call(:head, url)
  end
end
