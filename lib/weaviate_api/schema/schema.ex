defmodule Noizu.Weaviate.Api.Schema do
  @moduledoc """
  Noizu.Weaviate.Api.Schema is a module that provides functionality for interacting with the Weaviate schema API.
  This module offers various functions for configuring classes, properties, vector indices, inverted index, stopwords, and replication in the Weaviate schema.

  ## Usage

  To use this module, you need to call the respective function with the required parameters.

  Example:

      class_name = "Product"
      class_config = %{class_name: class_name, description: "A class for representing products in Weaviate"}

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_class(class_name, class_config)
  """

  alias Noizu.Weaviate
  import Noizu.Weaviate
  #-------------------------------
  # Class Configuration
  #-------------------------------

  @doc """
  Configures a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `class_config` (required) - The configuration settings for the class.

  ## Example

      class_name = "Product"
      class_config = %{
        name: class_name,
        description: "A class for representing products in Weaviate"
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_class(class_name, class_config)
  """
  @spec configure_class(String.t(), map()) :: Weaviate.api_response()
  def configure_class(class_name, class_config) do
    url = weaviate_base() <> "schema/#{class_name}"
    body = class_config

    api_call(:put, url, body, :json, nil)
  end

  #-------------------------------
  # Property Configuration
  #-------------------------------

  @doc """
  Adds a property to a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `property` (required) - The property to add.

  ## Example

      class_name = "Product"
      property = %{
        name: "price",
        description: "The price of the product",
        data_type: "number"
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.add_property(class_name, property)
  """
  @spec add_property(String.t(), Weaviate.Property.t()) :: Weaviate.api_response()
  def add_property(class_name, property) do
    url = weaviate_base() <> "schema/#{class_name}/properties"
    body = property

    api_call(:put, url, body, :json, nil)
  end

  #-------------------------------
  # Vector Index Configuration
  #-------------------------------

  @doc """
  Configures vector indices for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `vector_indices` (required) - The configuration settings for the vector indices.

  ## Example

      class_name = "Product"
      vector_indices = %{
        indexType: "hnsw",
        ...
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_vector_indices(class_name, vector_indices)
  """
  @spec configure_vector_indices(String.t(), map()) :: Weaviate.api_response()
  def configure_vector_indices(class_name, vector_indices) do
    url = weaviate_base() <> "schema/#{class_name}/vector-index-config"
    body = vector_indices

    api_call(:put, url, body, :json, nil)
  end

  #-------------------------------
  # Inverted Index Configuration
  #-------------------------------

  @doc """
  Configures inverted index for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `inverted_index` (required) - The configuration settings for the inverted index.

  ## Example

      class_name = "Product"
      inverted_index = %{
        cleanupIntervalSeconds: 600,
        maximumCleanupDurationSeconds: 1800
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_inverted_index(class_name, inverted_index)
  """
  @spec configure_inverted_index(String.t(), map()) :: Weaviate.api_response()
  def configure_inverted_index(class_name, inverted_index) do
    url = weaviate_base() <> "schema/#{class_name}/inverted-index-config"
    body = inverted_index

    api_call(:put, url, body, :json, nil)
  end

  #-------------------------------
  # Stopwords Configuration
  #-------------------------------

  @doc """
  Configures stopwords for a class in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `stopwords_config` (required) - The configuration settings for the stopwords.

  ## Example

      class_name = "Product"
      stopwords_config = %{
        remove: ["is", "the", "and"],
        additional: ["a", "an", "in"]
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_stopwords(class_name, stopwords_config)
  """
  @spec configure_stopwords(String.t(), map()) :: Weaviate.api_response()
  def configure_stopwords(class_name, stopwords_config) do
    url = weaviate_base() <> "schema/#{class_name}/stopwords-config"
    body = stopwords_config

    api_call(:put, url, body, :json, nil)
  end

  #-------------------------------
  # Replication Configuration
  #-------------------------------

  @doc """
  Configures replication in the Weaviate schema.

  ## Parameters

  - `class_name` (required) - The name of the class.
  - `replication_config` (required) - The replication configuration settings.

  ## Example

      class_name = "Product"
      replication_config = %{
        f: 2
      }

      {:ok, response} = Noizu.Weaviate.Api.Schema.configure_replication(class_name, replication_config)
  """
  @spec configure_replication(String.t(), map()) :: Weaviate.api_response()
  def configure_replication(class_name, replication_config) do
    url = weaviate_base() <> "schema/#{class_name}/replication-config"
    body = replication_config

    api_call(:put, url, body, :json, nil)
  end
end
