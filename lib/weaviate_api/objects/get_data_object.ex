defmodule WeaviateApi.Objects.GetDataObject do
  @moduledoc """
  Functions for fetching a data object by ID in Weaviate.
  """

  @doc """
  Get a data object in Weaviate by ID.

  ## Parameters

  - `class_name` (required) - The class name of the data object.
  - `id` (required) - The ID of the data object to fetch.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.GetDataObject.get_data_object("Product", "1234-abcd-5678-efgh")
  """
  @spec get_data_object(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def get_data_object(class_name, id) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}"

    # Make the API request
    api_call(:get, url)
  end
end
