defmodule Noizu.Weaviate.Struct.BatchParams do
  defstruct [
    :consistency_level
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil) do
    nil
  end
  def from_json(%{} = json) do
    %__MODULE__{
      consistency_level: json[:consistencyLevel]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        consistencyLevel: this.consistency_level,
      }
      |> Enum.reject(fn {_k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
