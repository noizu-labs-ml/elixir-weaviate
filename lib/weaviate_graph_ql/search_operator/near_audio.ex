defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearAudio do
  defstruct [
    audio: nil,
    distance: nil,
    certainty: nil,
    target_vectors: nil
  ]


  # ⟦𓎮𓆼𓅱𓌿⟧ filter :: auto-generated pointer for public function filter
  def filter(container, audio, options \\ nil) do
    target_vectors = case options[:target_vectors] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    operator = %__MODULE__{
      audio: audio,
      distance: options[:distance],
      certainty: options[:certainty],
      target_vectors: target_vectors
    }
    container.__struct__.search_operator(container, operator)
  end


  defimpl Jason.Encoder do
    # ⟦𓇎𓏙𓊑𓀖⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do
      contents =
        []
        |> then(& [{:audio, this.audio} | &1])
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> then(& this.target_vectors && [{:targetVectors, this.target_vectors} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}" end)
        |> Enum.join(",\n  ")
      """
      nearAudio: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
