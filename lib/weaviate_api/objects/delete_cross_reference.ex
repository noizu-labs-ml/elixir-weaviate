defmodule WeaviateApi.Objects.DeleteCrossReference do
  @moduledoc """
  Functions for deleting a cross-reference in Weaviate.
  """

  @doc """
  Delete a cross-reference in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class of the source object.
  - `id` (required) - The ID of the source object.
  - `property_name` (required) - The name of the property containing the cross-reference.
  - `beacon` (required) - The beacon URL of the reference to delete, in the format "weaviate://localhost/<ClassName>/<id>".

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.DeleteCrossReference.delete("Product", "1234", "relatedProducts", "weaviate://localhost/Product/5678")
  """
  @spec delete(String.t(), String.t(), String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def delete(class_name, id, property_name, beacon) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}/references/#{property_name}"

    # Construct the request body
    body = %{beacon: beacon}

    # Make the API request to delete the cross-reference
    api_call(:delete, url, body)
  end
end
