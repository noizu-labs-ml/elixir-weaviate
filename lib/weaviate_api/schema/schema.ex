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
  # -------------------------------
  # Schema
  # -------------------------------
  @spec get(options :: any) ::
          {:ok, any()} | {:error, any()}
  def get(options \\ nil) do
    url = api_base() <> "v1/schema"
    api_call(:get, url, nil, Noizu.Weaviate.Struct.Schema, options)
  end


  #------------------------------------------------
  # Noizu.Weaviate.Api.Schema.Class
  #------------------------------------------------
  defmodule Class do
    alias Noizu.Weaviate
    import Noizu.Weaviate


    @spec create(class :: Noizu.Weaviate.Struct.Class.t, options :: any) ::
            {:ok, any()} | {:error, any()}
    def create(class, options \\ nil) do
      url = api_base() <> "v1/schema"
      api_call(:post, url, class, Noizu.Weaviate.Struct.Class, options)
    end

    @spec get(class :: String.t | Noizu.Weaviate.Struct.Class.t, options :: any) ::
            {:ok, any()} | {:error, any()}
    def get(class, options \\ nil) do
      class = case class do
        %{name: name} -> name
        name when is_bitstring(name) -> name
      end
      url = api_base() <> "v1/schema/#{class}"
      api_call(:get, url, nil, Noizu.Weaviate.Struct.Class, options)
    end

    @spec update(class :: Noizu.Weaviate.Struct.Class.t, options :: any) ::
            {:ok, any()} | {:error, any()}
    def update(class, options \\ nil) do
      url = api_base() <> "v1/schema/#{class.name}"
      api_call(:put, url, class, Noizu.Weaviate.Struct.Class, options)
    end

    @spec delete(class :: String.t | Noizu.Weaviate.Struct.Class.t, options :: any) ::
            {:ok, any()} | {:error, any()}
    def delete(class, options \\ nil) do
      class = case class do
        %{name: name} -> name
        name when is_bitstring(name) -> name
      end
      url = api_base() <> "v1/schema/#{class}"
      api_call(:delete, url, nil, :json, options)
    end

    #------------------------------------------------
    # Noizu.Weaviate.Api.Schema.Class.Properties
    #------------------------------------------------
    defmodule Properties do
      alias Noizu.Weaviate
      import Noizu.Weaviate

      @spec add(class :: Noizu.Weaviate.Struct.Class.t | String.t, property :: Noizu.Weaviate.Struct.Property.t, options :: any) ::
              {:ok, any()} | {:error, any()}
      def add(class, property, options \\ nil) do
        class = case class do
          %{name: name} -> name
          name when is_bitstring(name) -> name
        end
        url = api_base() <> "v1/schema/#{class}/properties"
        api_call(:post, url, property, Noizu.Weaviate.Struct.Property, options)
      end

    end

    #------------------------------------------------
    # Noizu.Weaviate.Api.Schema.Class.Shards
    #------------------------------------------------
    defmodule Shards do
      alias Noizu.Weaviate
      import Noizu.Weaviate

      @spec get(class :: Noizu.Weaviate.Struct.Class.t | String.t, options :: any) ::
              {:ok, any()} | {:error, any()}
      def get(class, options \\ nil) do
        class = case class do
          %{name: name} -> name
          name when is_bitstring(name) -> name
        end
        url = api_base() <> "v1/schema/#{class}/shards"
        api_call(:get, url, nil, :json, options)
      end

      @spec update(class :: Noizu.Weaviate.Struct.Class.t | String.t, shard :: any, status :: atom, options :: any) ::
              {:ok, any()} | {:error, any()}
      def update(class, shard, status, options \\ nil) do
        class = case class do
          %{name: name} -> name
          name when is_bitstring(name) -> name
        end
        shard = case shard do
          %{name: name} -> name
          name when is_bitstring(name) -> name
        end
        url = api_base() <> "v1/schema/#{class}/shards/#{shard}}"
        status = %{
          status: status
        }
        api_call(:put, url, status, :json, options)
      end

    end

    #------------------------------------------------
    # Noizu.Weaviate.Api.Schema.Class.Tenants
    #------------------------------------------------
    defmodule Tenants do
      alias Noizu.Weaviate
      import Noizu.Weaviate

      # -------------------------------
      # Class Tenancy
      # -------------------------------
      @spec get(class :: Noizu.Weaviate.Struct.Class.t | String.t, options :: any) ::
              {:ok, any()} | {:error, any()}
      def get(class, options \\ nil) do
        class = case class do
          %{name: name} -> name
          name when is_bitstring(name) -> name
        end
        url = api_base() <> "v1/schema/#{class}/tenants"
        api_call(:get, url, nil, :json, options)
      end

      @spec add(class :: Noizu.Weaviate.Struct.Class.t | String.t, tenants :: Noizu.Weaviate.Struct.Tenant.t | [Noizu.Weaviate.Struct.Tenant.t], options :: any) ::
              {:ok, any()} | {:error, any()}
      def add(class, tenants, options \\ nil) do
        class = case class do
          %{name: name} -> name
          name when is_bitstring(name) -> name
        end
        url = api_base() <> "v1/schema/#{class}/tenants"
        tenants = cond do
          is_list(tenants) -> tenants
          :else -> [tenants]
        end
        api_call(:get, url, tenants, :json, options)
      end

      @spec remove(class :: Noizu.Weaviate.Struct.Class.t | String.t, tenants :: Noizu.Weaviate.Struct.Tenant.t | [Noizu.Weaviate.Struct.Tenant.t], options :: any) ::
              {:ok, any()} | {:error, any()}
      def remove(class, tenants, options \\ nil) do
        class = case class do
          %{name: name} -> name
          name when is_bitstring(name) -> name
        end
        url = api_base() <> "v1/schema/#{class}/tenants"
        tenants = cond do
          is_list(tenants) ->
            Enum.map(tenants,
              fn
                (%{name: name}) -> name
                (name) when is_bitstring(name) -> name
              end
            )
          :else ->
            case tenants do
              %{name: name} -> [name]
              name when is_bitstring(name) -> [name]
            end
        end
        api_call(:delete, url, tenants, :json, options)
      end
    end
  end
end
