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
  # ⟦𓆗𓀭𓃜𓋓⟧ get :: auto-generated pointer for public function get
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


    @spec create(class :: module, options :: any) ::
            {:ok, any()} | {:error, any()}
    # ⟦𓎈𓎄𓐗𓀮⟧ create :: auto-generated pointer for public function create
    def create(class, options \\ nil) do
      url = api_base() <> "v1/schema"
      api_call(:post, url, Noizu.Weaviate.Class.definition(class), Noizu.Weaviate.Class.json_handler(class), options)
    end

    @spec get(class :: String.t | module, options :: any) ::
            {:ok, any()} | {:error, any()}
    def get(class, options \\ nil) do
      class = case class do
        %Noizu.Weaviate.Struct.Class{name: name} -> name
        name when is_bitstring(name) -> name
        m -> Noizu.Weaviate.Class.definition(class).name
      end
      url = api_base() <> "v1/schema/#{class}"
      api_call(:get, url, nil, Noizu.Weaviate.Class.json_handler(class), options)
    end

    @spec update(class :: module, options :: any) ::
            {:ok, any()} | {:error, any()}
    # ⟦𓂤𓀈𓆲𓉚⟧ update :: auto-generated pointer for public function update
    def update(class, options \\ nil) do
      class = case class do
        %Noizu.Weaviate.Struct.Class{} -> class
        m -> Noizu.Weaviate.Class.definition(class)
      end
      url = api_base() <> "v1/schema/#{class.name}"
      api_call(:put, url, Noizu.Weaviate.Class.definition(class), Noizu.Weaviate.Class.json_handler(class), options)
    end

    @spec delete(class :: String.t | module, options :: any) ::
            {:ok, any()} | {:error, any()}
    # ⟦𓅌𓅝𓇑𓐄⟧ delete :: auto-generated pointer for public function delete
    def delete(class, options \\ nil) do
      class = case class do
        %Noizu.Weaviate.Struct.Class{name: name} -> name
        name when is_bitstring(name) -> name
        m -> Noizu.Weaviate.Class.definition(class).name
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

      @spec add(class :: module | String.t, property :: Noizu.Weaviate.Struct.Property.t, options :: any) ::
              {:ok, any()} | {:error, any()}
      # ⟦𓌁𓆧𓀚𓇉⟧ add :: auto-generated pointer for public function add
      def add(class, property, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
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

      @spec get(class :: module | String.t, options :: any) ::
              {:ok, any()} | {:error, any()}
      def get(class, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
        end
        url = api_base() <> "v1/schema/#{class}/shards"
        api_call(:get, url, nil, :json, options)
      end

      @spec update(class :: module | String.t, shard :: any, status :: atom, options :: any) ::
              {:ok, any()} | {:error, any()}
      def update(class, shard, status, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
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
      @spec get(class :: module | String.t, options :: any) ::
              {:ok, any()} | {:error, any()}
      def get(class, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
        end
        url = api_base() <> "v1/schema/#{class}/tenants"
        api_call(:get, url, nil, :json, options)
      end

      @spec add(class :: module | String.t, tenants :: Noizu.Weaviate.Struct.Tenant.t | [Noizu.Weaviate.Struct.Tenant.t], options :: any) ::
              {:ok, any()} | {:error, any()}
      def add(class, tenants, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
        end
        url = api_base() <> "v1/schema/#{class}/tenants"
        tenants = cond do
          is_list(tenants) -> tenants
          :else -> [tenants]
        end
        api_call(:post, url, tenants, :json, options)
      end

      @spec remove(class :: module | String.t, tenants :: Noizu.Weaviate.Struct.Tenant.t | [Noizu.Weaviate.Struct.Tenant.t], options :: any) ::
              {:ok, any()} | {:error, any()}
      # ⟦𓁡𓇂𓌋𓎝⟧ remove :: auto-generated pointer for public function remove
      def remove(class, tenants, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
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

      @spec get_tenant(class :: module | String.t, tenant_name :: String.t, options :: any) ::
              {:ok, any()} | {:error, any()}
      # ⟦𓈳𓇘𓅋𓅥⟧ get_tenant :: auto-generated pointer for public function get_tenant
      def get_tenant(class, tenant_name, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
        end
        url = api_base() <> "v1/schema/#{class}/tenants/#{tenant_name}"
        api_call(:get, url, nil, :json, options)
      end

      @spec update(class :: module | String.t, tenants :: list | map, options :: any) ::
              {:ok, any()} | {:error, any()}
      def update(class, tenants, options \\ nil) do
        class = case class do
          %Noizu.Weaviate.Struct.Class{name: name} -> name
          name when is_bitstring(name) -> name
          m -> Noizu.Weaviate.Class.definition(class).name
        end
        url = api_base() <> "v1/schema/#{class}/tenants"
        tenants = cond do
          is_list(tenants) -> tenants
          :else -> [tenants]
        end
        api_call(:put, url, tenants, :json, options)
      end
    end
  end
end
