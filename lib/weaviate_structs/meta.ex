defmodule Noizu.Weaviate.Struct.Meta do
  defstruct [
    :hostname,
    :version,
    :modules
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      hostname: json[:hostname],
      version: json[:version],
      modules: json[:modules]
    }
  end
end
