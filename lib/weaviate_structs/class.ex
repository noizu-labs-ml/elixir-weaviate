defmodule WeaviateStructs.Class do
  @moduledoc """
  Struct for representing a class in Weaviate schema.
  """

  defstruct [:name, :description, :vectorizer, :vector_index, :vector_index_config, :inverted_index_config, :stopwords_config,
             :replication_config, :module_config, :properties, :inverted_index, :vector_indexer_done,
             :vector_search_available, :vector_search_config, :vector_search_indexer_done]

  @enforce_keys [:name]

  @type t :: %__MODULE__{
    name: String.t(),
    description: String.t(),
    vectorizer: String.t(),
    vector_index: String.t(),
    vector_index_config: map(),
    inverted_index_config: map(),
    stopwords_config: map(),
    replication_config: map(),
    module_config: map(),
    properties: list(WeaviateStructs.Property.t()),
    inverted_index: boolean,
    vector_indexer_done: boolean,
    vector_search_available: boolean,
    vector_search_config: map(),
    vector_search_indexer_done: boolean
  }
end
