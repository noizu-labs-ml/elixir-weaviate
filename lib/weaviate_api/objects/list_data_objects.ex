defmodule WeaviateApi.Objects.ListDataObjects do
  @moduledoc """
  Functions for listing data objects in Weaviate.
  """

  @doc """
  List data objects in Weaviate.

  ## Parameters

  - `class` (optional) - The class name to filter the data objects by.
  - `limit` (optional) - The maximum number of data objects to return. Default is 25.
  - `offset` (optional) - The offset of data objects returned (the starting index of the returned objects). Cannot be used with `after`. Should be used in conjunction with `limit`.
  - `after` (optional) - The ID of the object after which (i.e. non-inclusive ID) objects are to be listed. Must be used with `class`. Cannot be used with `offset` or `sort`. Should be used in conjunction with `limit`.
  - `include` (optional) - Additional information to include, such as classification info. Allowed values include: classification, vector, featureProjection, and other module-specific additional properties.
  - `sort` (optional) - Name of the property to sort by. You can also provide multiple names separated by commas.
  - `order` (optional) - Order in which to sort by. Possible values are "asc" (default) and "desc". Should be used in conjunction with `sort`.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.ListDataObjects.list_data_objects()
      {:ok, response} = WeaviateApi.Objects.ListDataObjects.list_data_objects(class: "Product", limit: 10)
  """
  @spec list_data_objects(map()) :: {:ok, any()} | {:error, any()}
  def list_data_objects(opts \\ %{}) do
    # Construct the request URL
    url = "/v1/objects"

    # Make the API request with the specified options
    api_call(:get, url, opts)
  end
end
