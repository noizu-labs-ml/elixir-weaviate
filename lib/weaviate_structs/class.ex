defmodule Noizu.Weaviate.Struct.Class do
  @moduledoc """
  Struct for representing a class in Weaviate schema.
  """

  defstruct [
    :name,
    :description,
    :vector_index,
    :vector_index_config,
    :vectorizer,
    :module_config,
    :properties,
    :inverted_index_config,
    :replication_config,
    :multi_tenancy_config
  ]

  @type t :: %__MODULE__{
               name: String.t(),
               description: String.t(),
               vector_index: String.t(),
               vector_index_config: Noizu.Weaviate.Struct.VectorIndexConfig.t,
               vectorizer: String.t(),
               module_config: map(),
               properties: list(Noizu.Weaviate.Struct.Property.t()),

               inverted_index_config: Noizu.Weaviate.Struct.InvertedIndexConfig.t,
               replication_config: Noizu.Weaviate.Struct.ReplicationConfig.t,
               multi_tenancy_config: Noizu.Weaviate.Struct.MultiTenancyConfig.t,
             }

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      name: json[:class],
      description: json[:description],
      vector_index: json[:vectorIndex],
      vector_index_config: Noizu.Weaviate.Struct.VectorIndexConfig.from_json(json[:vectorIndexConfig]),
      vectorizer: json[:vectorizer],
      module_config: json[:moduleConfig],
      properties: Noizu.Weaviate.Struct.Property.from_json(json[:properties]),
      inverted_index_config: Noizu.Weaviate.Struct.InvertedIndexConfig.from_json(json[:invertedIndexConfig]),
      replication_config: Noizu.Weaviate.Struct.ReplicationConfig.from_json(json[:replicationConfig]),
      multi_tenancy_config: Noizu.Weaviate.Struct.MultiTenancyConfig.from_json(json[:multiTenancyConfig]),
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        class: this.name,
        description: this.description,
        vectorIndex: this.vector_index,
        vectorIndexConfig: this.vector_index_config,
        vectorizer: this.vectorizer,
        moduleConfig: this.module_config,
        properties: this.properties,
        invertedIndexConfig: this.inverted_index_config,
        replicationConfig: this.replication_config,
        multiTenancyConfig: this.multi_tenancy_config
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end

end
