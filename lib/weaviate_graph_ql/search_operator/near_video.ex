defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearVideo do
  defstruct [
    video: nil,
    distance: nil,
    certainty: nil,
    target_vectors: nil
  ]


  def filter(container, video, options \\ nil) do
    target_vectors = case options[:target_vectors] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    operator = %__MODULE__{
      video: video,
      distance: options[:distance],
      certainty: options[:certainty],
      target_vectors: target_vectors
    }
    container.__struct__.search_operator(container, operator)
  end


  defimpl Jason.Encoder do
    def encode(this, opts) do
      contents =
        []
        |> then(& [{:video, this.video} | &1])
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> then(& this.target_vectors && [{:targetVectors, this.target_vectors} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}" end)
        |> Enum.join(",\n  ")
      """
      nearVideo: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
