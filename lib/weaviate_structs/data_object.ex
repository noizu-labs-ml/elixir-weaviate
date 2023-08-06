defmodule Noizu.Weaviate.Struct.DataObject do
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

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      class_name: json[:className],
      properties: Noizu.Weaviate.Struct.Property.from_json(json[:properties]),
      additional_properties: json[:additionalProperties],
      vector: json[:vector],
      id: json[:id],
      tenant: json[:tenant]
    }
  end
end
