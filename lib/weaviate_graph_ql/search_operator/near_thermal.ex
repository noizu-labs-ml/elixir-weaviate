defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearThermal do
  defstruct [
    thermal: nil,
    distance: nil,
    certainty: nil,
    target_vectors: nil
  ]


  # ⟦𓆪𓃔𓍜𓂓⟧ filter :: auto-generated pointer for public function filter
  def filter(container, thermal, options \\ nil) do
    target_vectors = case options[:target_vectors] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    operator = %__MODULE__{
      thermal: thermal,
      distance: options[:distance],
      certainty: options[:certainty],
      target_vectors: target_vectors
    }
    container.__struct__.search_operator(container, operator)
  end


  defimpl Jason.Encoder do
    # ⟦𓁒𓅠𓃻𓇎⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do
      contents =
        []
        |> then(& [{:thermal, this.thermal} | &1])
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> then(& this.target_vectors && [{:targetVectors, this.target_vectors} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}" end)
        |> Enum.join(",\n  ")
      """
      nearThermal: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
