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

  def from_json(%{
        "class_name" => class_name,
        "properties" => properties,
        "additional_properties" => additional_properties,
        "vector" => vector,
        "id" => id,
        "tenant" => tenant
      }) do
    properties = Enum.map(properties, &WeaviateStructs.Property.from_json/1)

    %__MODULE__{
      class_name: class_name,
      properties: properties,
      additional_properties: additional_properties,
      vector: vector,
      id: id,
      tenant: tenant
    }
  end
end
