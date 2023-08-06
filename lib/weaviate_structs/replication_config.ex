defmodule Noizu.Weaviate.Struct.ReplicationConfig do
  defstruct [
    :factor
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      factor: json[:factor]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        factor: this.factor
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
