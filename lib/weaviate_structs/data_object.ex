defmodule WeaviateStructs.DataObject do
  @moduledoc """
  Struct for representing a data object in Weaviate.
  """

  defstruct [:class_name, :properties, :additional_properties, :id, :vector, :tenant]

  @enforce_keys [:class_name, :properties]

  @type t :: %__MODULE__{
    class_name: String.t(),
    properties: map(),
    additional_properties: map(),
    id: String.t(),
    vector: list(number()),
    tenant: String.t()
  }
end
