defmodule Noizu.Weaviate.Struct.OpenIDConfiguration do
  defstruct [
    :href,
    :client_id
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      href: json[:href],
      client_id: json[:clientID]
    }
  end
end
