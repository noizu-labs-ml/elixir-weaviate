defmodule Noizu.Weaviate.Struct.InvertedIndexConfig.Stopwords do
  defstruct [
    :preset,
    :additions,
    :removals
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil) do
    nil
  end
  def from_json(%{} = json) do
    %__MODULE__{
      preset: json[:preset],
      additions: json[:additions],
      removals: json[:removals]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        preset: this.preset,
        additions: this.additions,
        removals: this.removals
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
