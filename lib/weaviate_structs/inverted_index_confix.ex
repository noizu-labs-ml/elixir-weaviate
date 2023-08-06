defmodule Noizu.Weaviate.Struct.InvertedIndexConfig do
  defstruct [
    stopwords: nil,
    bm25: nil,
    index_timestamps: false,
    index_null_state: false,
    index_property_length: false
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      stopwords: Noizu.Weaviate.Struct.InvertedIndexConfig.Stopwords.from_json(json[:stopwords]),
      bm25: Noizu.Weaviate.Struct.InvertedIndexConfig.BM25.from_json(json[:bm25]),
      index_timestamps: json[:indexTimestamps],
      index_null_state: json[:indexNullState],
      index_property_length: json[:indexPropertyLength]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        stopwords: this.stopwords,
        bm25: this.bm25,
        indexTimestamps: this.index_timestamps,
        indexNullState: this.index_null_state,
        indexPropertyLength: this.index_property_length
      }
      |> Enum.reject(fn {_, v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
