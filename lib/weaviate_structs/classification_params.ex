defmodule WeaviateStructs.ClassificationParams do
  @moduledoc """
  Struct for representing classification parameters in Weaviate.
  """

  defstruct [:class_name, :classify_properties, :based_on_properties, :type]

  @enforce_keys [:class_name, :classify_properties, :based_on_properties, :type]

  @type t :: %__MODULE__{
    class_name: String.t(),
    classify_properties: list(String.t()),
    based_on_properties: list(String.t()),
    type: String.t()
  }
end
