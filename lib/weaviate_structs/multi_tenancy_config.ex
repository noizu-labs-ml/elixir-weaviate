defmodule Noizu.Weaviate.Struct.MultiTenancyConfig do
  defstruct [
    :enabled
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      enabled: json[:enabled]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        enabled: this.enabled
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
