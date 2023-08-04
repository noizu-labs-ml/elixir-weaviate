defmodule WeaviateStructs.BatchParams do
  defstruct [
    :consistency_level
  ]

  def from_json(%{
    "consistency_level" => consistency_level
  }) do
    %__MODULE__{
      consistency_level: consistency_level
    }
  end
end
