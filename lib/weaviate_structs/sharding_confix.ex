defmodule Noizu.Weaviate.Struct.ShardingConfig do
  defstruct [
    :virtual_per_physical,
    :desired_count,
    :actual_count,
    :desired_virtual_count,
    :actual_virtual_count,
    :key,
    :strategy,
    :function
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      virtual_per_physical: json[:virtualPerPhysical],
      desired_count: json[:desiredCount],
      actual_count: json[:actualCount],
      desired_virtual_count: json[:desiredVirtualCount],
      actual_virtual_count: json[:actualVirtualCount],
      key: json[:key],
      strategy: json[:strategy],
      function: json[:function]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        virtualPerPhysical: this.virtual_per_physical,
        desiredCount: this.desired_count,
        actualCount: this.actual_count,
        desiredVirtualCount: this.desired_virtual_count,
        actualVirtualCount: this.actual_virtual_count,
        key: this.key,
        strategy: this.strategy,
        function: this.function
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
