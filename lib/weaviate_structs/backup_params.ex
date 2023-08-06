defmodule Noizu.Weaviate.Struct.BackupParams do
  defstruct [
    :backend,
    :id,
    :include,
    :exclude
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end

  def from_json(%{} = json) do
    %__MODULE__{
      backend: json[:backend],
      id: json[:id],
      include: json[:include],
      exclude: json[:exclude]
    }
  end
end
