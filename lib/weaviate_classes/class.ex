defmodule Noizu.Weaviate.Class do
  @moduledoc """
  Main class to provide functionalities for Weaviate classes.
  """

  defmodule Meta do
    defmodule Classification do
      defstruct [
        id: nil,
        based_on: nil,
        classified_fields: nil,
        completed: nil,
        scope: nil,
        vector: nil
      ]
    end

    defstruct [
      id: nil,
      class: nil,
      description: nil,
      creation_time_unix: nil,
      last_update_time_unix: nil,
      vector: nil,
      vectors: nil,
      tenant: nil,
      classification: nil,
      feature_projection: nil,
    ]
  end

  # ⟦𓊆𓊙𓄤𓇼⟧ __using__ :: auto-generated pointer for public function __using__
  defmacro __using__(options \\ nil) do
    quote do
      Module.register_attribute(__MODULE__, :properties, accumulate: true)
      Module.register_attribute(__MODULE__, :class_description, accumulate: false)
      Module.register_attribute(__MODULE__, :class_vector_index_type, accumulate: false)
      Module.register_attribute(__MODULE__, :class_vector_index_config, accumulate: false)
      Module.register_attribute(__MODULE__, :class_vectorizer, accumulate: false)
      Module.register_attribute(__MODULE__, :class_module_config, accumulate: false)
      Module.register_attribute(__MODULE__, :class_inverted_index_config, accumulate: false)
      Module.register_attribute(__MODULE__, :class_replication_config, accumulate: false)
      Module.register_attribute(__MODULE__, :class_multi_tenancy_config, accumulate: false)
      Module.register_attribute(__MODULE__, :class_vector_config, accumulate: false)
      Module.register_attribute(__MODULE__, :class_sharding_config, accumulate: false)

      require Noizu.Weaviate.Class
      import Noizu.Weaviate.Class, only: [weaviate_class: 2]
    end
  end

  # ⟦𓅢𓄛𓍈𓄰⟧ weaviate_class :: auto-generated pointer for public function weaviate_class
  defmacro weaviate_class(class_name, [do: block]) do
    quote do
      import Noizu.Weaviate.Class
      unquote(block)

      # Define the struct
      struct_params =
      [meta: %Noizu.Weaviate.Class.Meta{
        id: nil,
        class: unquote(class_name),
        description: @class_description,
        creation_time_unix: nil,
        last_update_time_unix: nil,
        vector: nil,
        vectors: nil,
        tenant: nil,
        classification: nil,
        feature_projection: nil,
      }, id: nil] ++ Enum.map(@properties, fn {name, _} -> {name, nil} end)


      @derive Noizu.Weaviate.Class.Protocol
      defstruct struct_params

      # ⟦𓄬𓈕𓀪𓍴⟧ __class__ :: auto-generated pointer for public function __class__
      def __class__(), do: unquote(class_name)
      # ⟦𓈝𓏙𓌆𓐈⟧ __properties__ :: auto-generated pointer for public function __properties__
      def __properties__(), do: @properties
      # ⟦𓊷𓎚𓆂𓄦⟧ __property__ :: auto-generated pointer for public function __property__
      def __property__(name), do: Enum.find_value(@properties, fn {k,v} -> k == name && v end)

      # ⟦𓁉𓂟𓎖𓁕⟧ definition :: auto-generated pointer for public function definition
      def definition() do
        %Noizu.Weaviate.Struct.Class{
          name: unquote(class_name),
          description: @class_description,
          vector_index: @class_vector_index_type,
          vector_index_config: @class_vector_index_config,
          vectorizer: @class_vectorizer,
          module_config: @class_module_config,
          inverted_index_config: @class_inverted_index_config,
          replication_config: @class_replication_config,
          multi_tenancy_config: @class_multi_tenancy_config,
          vector_config: @class_vector_config,
          sharding_config: @class_sharding_config,
          properties: Enum.map(@properties, fn({_, v}) -> v end),
        }
      end

      # ⟦𓁷𓏃𓋍𓏑⟧ from_json :: auto-generated pointer for public function from_json
      def from_json(json) do
        meta = %Noizu.Weaviate.Class.Meta{
          id: json[:id],
          class: json[:class],
          creation_time_unix: json[:creationTimeUnix],
          last_update_time_unix: json[:lastUpdateTimeUnix],
          vector: json[:vector],
          vectors: json[:vectors],
          tenant: json[:tenant],
          classification: json[:classification],
          feature_projection: json[:featureProjection]
        }
        properties = Enum.map(apply(__MODULE__,:__properties__, []), fn {name, _} -> {name, json[:properties][name]} end)
        __MODULE__.__struct__([{:meta, meta}, {:id, json[:id]} |properties])
      end


      defimpl Jason.Encoder do
        # ⟦𓃎𓎊𓏷𓍮⟧ encode :: auto-generated pointer for public function encode
        def encode(this, opts) do
          [
            id: this.id,
            class: this.meta.class,
            vector: this.meta.vector,
            vectors: this.meta.vectors,
            tenant: this.meta.tenant,
            properties:
              Enum.map(apply(this.__struct__,:__properties__, []), fn({k, _}) -> {k, get_in(this, [Access.key(k)])} end)
              |> Enum.reject(fn({_,v}) -> is_nil(v) end)
              |> Map.new()
          ] |> Enum.reject(fn({_,v}) -> is_nil(v) end)
          |> Map.new()
          |> Jason.Encode.map(opts)
        end
      end

      defoverridable [
        __properties__: 0,
        __property__: 1,
        definition: 0,
        from_json: 1
      ]

    end
  end

  def definition(class, options \\ nil)
  def definition(%Noizu.Weaviate.Struct.Class{} = class, options), do: class
  def definition(class, options), do: apply(class, :definition, [])

  # ⟦𓋕𓅺𓏙𓎯⟧ json_handler :: auto-generated pointer for public function json_handler
  def json_handler(class, options \\ nil)
  def json_handler(%Noizu.Weaviate.Struct.Class{}, _options), do: Noizu.Weaviate.Struct.Class
  def json_handler(class, _options) when is_atom(class), do: class
  def json_handler(_, _options), do: Noizu.Weaviate.Struct.Class

  #===================================
  # Macros
  #===================================

  # ⟦𓁡𓇜𓆘𓎦⟧ description :: auto-generated pointer for public function description
  defmacro description(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_description, unquote(value))
    end
  end
  # ⟦𓏵𓆏𓁖𓋠⟧ vector_index_type :: auto-generated pointer for public function vector_index_type
  defmacro vector_index_type(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_vector_index_type, unquote(value))
    end
  end
  # ⟦𓄷𓏄𓆈𓋊⟧ vector_index_config :: auto-generated pointer for public function vector_index_config
  defmacro vector_index_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_vector_index_config, unquote(value))
    end
  end
  # ⟦𓎊𓆔𓋶𓉬⟧ vectorizer :: auto-generated pointer for public function vectorizer
  defmacro vectorizer(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_vectorizer, unquote(value))
    end
  end
  # ⟦𓏿𓅝𓂔𓊬⟧ module_config :: auto-generated pointer for public function module_config
  defmacro module_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_module_config, unquote(value))
    end
  end
  # ⟦𓉓𓁋𓇟𓄬⟧ inverted_index_config :: auto-generated pointer for public function inverted_index_config
  defmacro inverted_index_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_inverted_index_config, unquote(value))
    end
  end
  # ⟦𓆾𓉎𓉠𓏔⟧ replication_config :: auto-generated pointer for public function replication_config
  defmacro replication_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_replication_config, unquote(value))
    end
  end
  # ⟦𓅈𓏿𓃫𓈴⟧ multi_tenancy_config :: auto-generated pointer for public function multi_tenancy_config
  defmacro multi_tenancy_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_multi_tenancy_config, unquote(value))
    end
  end
  # ⟦𓀾𓉩𓐫𓀐⟧ vector_config :: auto-generated pointer for public function vector_config
  defmacro vector_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_vector_config, unquote(value))
    end
  end
  # ⟦𓍼𓀇𓀖𓀙⟧ sharding_config :: auto-generated pointer for public function sharding_config
  defmacro sharding_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_sharding_config, unquote(value))
    end
  end

  # ⟦𓂀𓈩𓎠𓄧⟧ property :: auto-generated pointer for public function property
  defmacro property(name, data_type, opts \\ []) do
    quote do
      Module.put_attribute(__MODULE__, :properties, {unquote(name), %Noizu.Weaviate.Struct.Property{
        name: unquote(name),
        data_type: ["#{unquote(data_type)}"],
        description: Keyword.get(unquote(opts), :description, nil),
        index_filterable: Keyword.get(unquote(opts), :index_filterable, nil),
        index_searchable: Keyword.get(unquote(opts), :index_searchable, nil),
        index_inverted: Keyword.get(unquote(opts), :index_inverted, nil),
        tokenization: Keyword.get(unquote(opts), :tokenization, nil),
        module_config: Keyword.get(unquote(opts), :module_config, nil)
      }})
    end
  end



end
