defmodule Noizu.Weaviate.Api.Schema do
  @moduledoc """
  Functions for interacting with the Weaviate schema API.
  """

  @doc """
  Create or update a class.

  ## Parameters

  - `class_name` - The name of the class.
  - `class_config` - The configuration settings for the class.

  ## Example

      class_name = "Person"
      class_config = %{
        c: class_name,
        d: "A class for representing people in Weaviate",
        ...
      }
      Noizu.Weaviate.Api.Schema.configure_class(class_name, class_config)
  """
  @spec configure_class(String.t, map()) :: {:ok, map()} | {:error, map()}
  def configure_class(class_name, class_config) do
    url = "/v1/schema/#{class_name}"
    Noizu.Weaviate.Api.request(:put, url, class_config)
  end

  @doc """
  Add a property to a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `property` (required) - The property to add. It should be a map with the following keys:
    - `name` (required) - The name of the property.
    - `data_type` (required) - The data type of the property.
    - `text_keyword` (optional) - The text keyword for the property.
    - `index_inverted` (optional) - Flag indicating if the property should be indexed using an inverted index.
    - `index_vector` (optional) - Flag indicating if the property should be indexed using a vector index.
    - `module_config` (optional) - Configuration settings for the property.
    - `keywords` (optional) - Additional keywords for the property.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      property = %{
        name: "description",
        data_type: "text",
        text_keyword: "description",
        index_inverted: true,
        index_vector: false,
        module_config: %{},
        keywords: ["property", "description"]
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.add_property("Product", property)
  """
  @spec add_property(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def add_property(class_name, property) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/properties"

    # Make the API request with the specified property
    Noizu.Weaviate.Api.request(:put, url, property)
  end

  @doc """
  Configure a property of a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `property_name` (required) - The name of the property to configure.
  - `property_config` (required) - The configuration settings for the property.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      property_config = %{
        "dataType": "string",
        "description": "The name of the product",
        "moduleConfig": %{}
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_property("Product", "name", property_config)
  """
  @spec configure_property(String.t(), String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_property(class_name, property_name, property_config) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/properties/#{property_name}"

    # Make the API request with the specified property configuration
    Noizu.Weaviate.Api.request(:put, url, property_config)
  end

  @doc """
  Configure vector indices for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `vector_indices` (required) - The configuration settings for the vector indices.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      vector_indices = %{
        "indexType": "hnsw"
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_vector_indices("Product", vector_indices)
  """
  @spec configure_vector_indices(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_vector_indices(class_name, vector_indices) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/vector-index-config"

    # Make the API request with the specified vector indices configuration
    Noizu.Weaviate.Api.request(:put, url, vector_indices)
  end

  @doc """
  Configure inverted index for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `inverted_index` (required) - The configuration settings for the inverted index.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      inverted_index = %{
        "cleanupIntervalSeconds": 600,
        "maximumCleanupDurationSeconds": 1800
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_inverted_index("Product", inverted_index)
  """
  @spec configure_inverted_index(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_inverted_index(class_name, inverted_index) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/inverted-index-config"

    # Make the API request with the specified inverted index configuration
    Noizu.Weaviate.Api.request(:put, url, inverted_index)
  end

  @doc """
  Configure stopwords for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `stopwords_config` (required) - The configuration settings for the stopwords.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      stopwords_config = %{
        "remove": ["is", "the", "and"],
        "additional": ["a", "an", "in"]
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_stopwords("Product", stopwords_config)
  """
  @spec configure_stopwords(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_stopwords(class_name, stopwords_config) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/stopwords-config"

    # Make the API request with the specified stopwords configuration
    Noizu.Weaviate.Api.request(:put, url, stopwords_config)
  end

  @doc """
  Configure replication in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `replication_config` (required) - The replication configuration settings.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      replication_config = %{
        "f": 2
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_replication("Product", replication_config)
  """
  @spec configure_replication(String.t(), map()) :: {:ok, any()} | {:error, any()}
  def configure_replication(class_name, replication_config) do
    # Construct the request URL
    url = "/v1/schema/#{class_name}/replication-config"

    # Make the API request with the specified replication configuration
    Noizu.Weaviate.Api.request(:put, url, replication_config)
  end

  @doc """
  Private function to make the API call.

  ## Parameters

  - `method` (required) - The HTTP method of the API call.
  - `url` (required) - The URL of the API endpoint.
  - `body` (optional) - The request body.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.
  """
  @spec api_call(atom(), String.t(), any()) :: {:ok, any()} | {:error, any()}
  defp api_call(method, url, body) do
    Noizu.Weaviate.Api.request(method, url, body)
  end
end
