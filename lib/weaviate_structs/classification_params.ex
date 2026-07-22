defmodule Noizu.Weaviate.Struct.ClassificationParams do
  @moduledoc """
  Struct for representing classification parameters in Weaviate.
  """

  defstruct [:class_name, :classify_properties, :based_on_properties, :type]

  @enforce_keys [:class_name, :classify_properties, :based_on_properties, :type]

  # ⟦𓉖𓍮𓏒𓉣⟧ from_json :: auto-generated pointer for public function from_json
  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil) do
    nil
  end
  def from_json(%{} = json) do
    %__MODULE__{
      class_name: json[:className],
      classify_properties: json[:classifyProperties],
      based_on_properties: json[:basedOnProperties],
      type: json[:type]
    }
  end
end
