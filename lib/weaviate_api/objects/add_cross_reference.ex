defmodule WeaviateApi.Objects.AddCrossReference do
  @moduledoc """
  Functions for adding a cross-reference to a data object in Weaviate.
  """

  @doc """
  Add a cross-reference to a data object in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class that the data object belongs to.
  - `id` (required) - The ID of the data object.
  - `property_name` (required) - The name of the property to add the cross-reference to.
  - `beacon` (required) - The beacon URL of the reference, in the format `weaviate://localhost/<ClassName>/<id>`.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.AddCrossReference.add_cross_reference("Person", "12345678-1234-1234-1234-1234567890ab", "friends", "weaviate://localhost/Person/87654321-4321-4321-4321-210987654321")
  """
  @spec add_cross_reference(String.t(), String.t(), String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def add_cross_reference(class_name, id, property_name, beacon) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}/references/#{property_name}"

    # Construct the request body
    body = %{beacon: beacon}

    # Make the API request with the specified parameters
    api_call(:post, url, body)
  end
end
