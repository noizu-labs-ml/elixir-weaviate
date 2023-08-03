defmodule WeaviateStructs.Property do
  @moduledoc """
  Struct for representing a property in Weaviate schema.
  """

  defstruct [:name, :description, :data_type, :text_keyword, :index_inverted, :index_vector, :module_config, :keywords]

  @enforce_keys [:name, :data_type]

  @type t :: %__MODULE__{
    name: String.t(),
    description: String.t(),
    data_type: String.t(),
    text_keyword: String.t(),
    index_inverted: boolean,
    index_vector: boolean,
    module_config: map(),
    keywords: list(String.t())
  }
end
