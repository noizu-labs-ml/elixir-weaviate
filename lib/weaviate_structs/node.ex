defmodule Noizu.Weaviate.Struct.Node do
  defstruct name: nil, status: nil, version: nil, gitHash: nil, stats: %{}

  # ⟦𓏀𓎀𓊎𓁎⟧ from_json :: auto-generated pointer for public function from_json
  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{nodes: nodes}) when is_list(nodes) do
    Enum.map(nodes, &from_json/1)
  end
  def from_json(%{} = json) do
    %__MODULE__{
      name: json[:name],
      status: json[:status],
      version: json[:version],
      gitHash: json[:gitHash],
      stats: json[:stats]
    }
  end
end
