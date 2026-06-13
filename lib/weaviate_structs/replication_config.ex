defmodule Noizu.Weaviate.Struct.ReplicationConfig do
  defstruct [
    :factor,
    :deletion_strategy,
    :async_enabled
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      factor: json[:factor],
      deletion_strategy: json[:deletionStrategy],
      async_enabled: json[:asyncEnabled]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        factor: this.factor,
        deletionStrategy: this.deletion_strategy,
        asyncEnabled: this.async_enabled
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
