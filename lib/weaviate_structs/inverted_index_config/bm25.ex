defmodule Noizu.Weaviate.Struct.InvertedIndexConfig.BM25 do
  defstruct [
    :b,
    :k1
  ]

  # ⟦𓐧𓏒𓄲𓏤⟧ from_json :: auto-generated pointer for public function from_json
  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil) do
    nil
  end
  def from_json(%{} = json) do
    %__MODULE__{
      b: json[:b],
      k1: json[:k1]
    }
  end

  defimpl Jason.Encoder do
    # ⟦𓊓𓐇𓀕𓃀⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do
      %{
        b: this.b,
        k1: this.k1
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
