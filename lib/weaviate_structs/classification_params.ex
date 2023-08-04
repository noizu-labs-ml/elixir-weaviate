defmodule WeaviateStructs.ClassificationParams do
  @moduledoc """
  Struct for representing classification parameters in Weaviate.
  """

  defstruct [:class_name, :classify_properties, :based_on_properties, :type]

  @enforce_keys [:class_name, :classify_properties, :based_on_properties, :type]

  def from_json(%{
        "class" => class,
        "classifyProperties" => classifyProperties,
        "basedOnProperties" => basedOnProperties,
        "type" => type
      }) do
    %__MODULE__{
      class: class,
      classify_properties: classifyProperties,
      based_on_properties: basedOnProperties,
      type: type
    }
  end
end
