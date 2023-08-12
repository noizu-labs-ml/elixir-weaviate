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
      tenant: nil,
      classification: nil,
      feature_projection: nil,
    ]
  end

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

      require Noizu.Weaviate.Class
      import Noizu.Weaviate.Class, only: [weaviate_class: 2]
    end
  end

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
        tenant: nil,
        classification: nil,
        feature_projection: nil,
      }, id: nil] ++ Enum.map(@properties, fn {name, _} -> {name, nil} end)


      @derive Noizu.Weaviate.Class.Protocol
      defstruct struct_params

      def __class__(), do: unquote(class_name)
      def __properties__(), do: @properties
      def __property__(name), do: Enum.find_value(@properties, fn {k,v} -> k == name && v end)

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
          properties: Enum.map(@properties, fn({_, v}) -> v end),
        }
      end

      def from_json(json) do
        meta = %Noizu.Weaviate.Class.Meta{
          id: json[:id],
          class: json[:class],
          creation_time_unix: json[:creationTimeUnix],
          last_update_time_unix: json[:lastUpdateTimeUnix],
          vector: json[:vector],
          tenant: json[:tenant],
          classification: json[:classification],
          feature_projection: json[:featureProjection]
        }
        properties = Enum.map(apply(__MODULE__,:__properties__, []), fn {name, _} -> {name, json[:properties][name]} end)
        __MODULE__.__struct__([{:meta, meta}, {:id, json[:id]} |properties])
      end


      defimpl Jason.Encoder do
        def encode(this, opts) do
          [
            id: this.id,
            class: this.meta.class,
            vector: this.meta.vector,
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

  def json_handler(class, options \\ nil)
  def json_handler(%Noizu.Weaviate.Struct.Class{}, _options), do: Noizu.Weaviate.Struct.Class
  def json_handler(class, _options) when is_atom(class), do: class
  def json_handler(_, _options), do: Noizu.Weaviate.Struct.Class

  #===================================
  # Macros
  #===================================

  defmacro description(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_description, unquote(value))
    end
  end
  defmacro vector_index_type(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_vector_index_type, unquote(value))
    end
  end
  defmacro vector_index_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_vector_index_config, unquote(value))
    end
  end
  defmacro vectorizer(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_vectorizer, unquote(value))
    end
  end
  defmacro module_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_module_config, unquote(value))
    end
  end
  defmacro inverted_index_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_inverted_index_config, unquote(value))
    end
  end
  defmacro replication_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_replication_config, unquote(value))
    end
  end
  defmacro multi_tenancy_config(value) do
    quote do
      Module.put_attribute(__MODULE__, :class_multi_tenancy_config, unquote(value))
    end
  end

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
