defmodule Noizu.Weaviate.Api.Objects do
  @moduledoc """
  Functions for interacting with data objects in Weaviate.
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

      {:ok, response} = WeaviateApi.Objects.add_cross_reference("Person", "12345678-1234-1234-1234-1234567890ab", "friends", "weaviate://localhost/Person/87654321-4321-4321-4321-210987654321")
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

  @doc """
  Check if a data object exists in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class that the data object belongs to.
  - `id` (required) - The ID of the data object.

  ## Returns

  A tuple `{:ok, exists}` on successful API call, where `exists` is a boolean indicating if the data object exists.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, exists} = WeaviateApi.Objects.check_if_data_object_exists("Product", "12345678-1234-1234-1234-1234567890ab")
  """
  @spec check_if_data_object_exists(String.t(), String.t()) :: {:ok, boolean()} | {:error, any()}
  def check_if_data_object_exists(class_name, id) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}"

    # Make the API request with the specified parameters
    api_call(:head, url)
  end

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
      {:ok, response} = WeaviateApi.Objects.create_data_object("Product", properties)
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

      {:ok, response} = WeaviateApi.Objects.delete_cross_reference("Product", "1234", "relatedProducts", "weaviate://localhost/Product/5678")
  """
  @spec delete_cross_reference(String.t(), String.t(), String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def delete_cross_reference(class_name, id, property_name, beacon) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}/references/#{property_name}"

    # Construct the request body
    body = %{beacon: beacon}

    # Make the API request to delete the cross-reference
    api_call(:delete, url, body)
  end

  @doc """
  Delete a data object in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class that the data object belongs to.
  - `id` (required) - The ID of the data object.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.delete_data_object("Person", "12345678-1234-1234-1234-1234567890ab")
  """
  @spec delete_data_object(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def delete_data_object(class_name, id) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}"

    # Make the API request with the specified parameters
    api_call(:delete, url)
  end

  @doc """
  Get a data object in Weaviate by ID.

  ## Parameters

  - `class_name` (required) - The class name of the data object.
  - `id` (required) - The ID of the data object to fetch.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.get_data_object("Product", "1234-abcd-5678-efgh")
  """
  @spec get_data_object(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def get_data_object(class_name, id) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}"

    # Make the API request
    api_call(:get, url)
  end

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

      {:ok, response} = WeaviateApi.Objects.list_data_objects()
      {:ok, response} = WeaviateApi.Objects.list_data_objects(class: "Product", limit: 10)
  """
  @spec list_data_objects(map()) :: {:ok, any()} | {:error, any()}
  def list_data_objects(opts \\ %{}) do
    # Construct the request URL
    url = "/v1/objects"

    # Make the API request with the specified options
    api_call(:get, url, opts)
  end

  @doc """
  Update a cross-reference in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class of the source object.
  - `id` (required) - The ID of the source object.
  - `property_name` (required) - The name of the property containing the cross-reference.
  - `beacon` (required) - The beacon URL of the reference, in the format "weaviate://localhost/<ClassName>/<id>".

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Objects.update_cross_reference("Product", "1234", "relatedProducts", "weaviate://localhost/Product/5678")
  """
  @spec update_cross_reference(String.t(), String.t(), String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def update_cross_reference(class_name, id, property_name, beacon) do
    # Construct the request URL
    url = "/v1/objects/#{class_name}/#{id}/references/#{property_name}"

    # Construct the request body
    body = %{beacon: beacon}

    # Make the API request to update the cross-reference
    api_call(:put, url, body)
  end

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

      {:ok, response} = WeaviateApi.Objects.update_data_object("Person", "12345678-1234-1234-1234-1234567890ab", properties)
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

      {:ok, response} = WeaviateApi.Objects.validate_data_object("Person", properties)
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
