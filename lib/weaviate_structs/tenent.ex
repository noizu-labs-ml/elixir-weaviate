
defmodule Noizu.Weaviate.Struct.Tenant do
  defstruct [
    :name,
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      name: json[:name],
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        name: this.name,
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
