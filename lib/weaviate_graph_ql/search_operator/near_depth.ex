defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearDepth do
  defstruct [
    depth: nil,
    distance: nil,
    certainty: nil,
    target_vectors: nil
  ]


  def filter(container, depth, options \\ nil) do
    target_vectors = case options[:target_vectors] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    operator = %__MODULE__{
      depth: depth,
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
        |> then(& [{:depth, this.depth} | &1])
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> then(& this.target_vectors && [{:targetVectors, this.target_vectors} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}" end)
        |> Enum.join(",\n  ")
      """
      nearDepth: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
