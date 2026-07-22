defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearObject do
  defstruct [
    id: nil,
    beacon: nil,
    distance: nil,
    certainty: nil,
    target_vectors: nil
  ]


  # ⟦𓐧𓏚𓍜𓌥⟧ filter :: auto-generated pointer for public function filter
  def filter(container, resource, options \\ nil) do
    {id, beacon} = cond do
      String.starts_with?(resource, "weaviate://") -> {nil, resource}
      :else -> {resource, nil}
    end

    target_vectors = case options[:target_vectors] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end

    operator = %__MODULE__{
      id: id,
      beacon: beacon,
      distance: options[:distance],
      certainty: options[:certainty],
      target_vectors: target_vectors
    }
    container.__struct__.search_operator(container, operator)
  end


  defimpl Jason.Encoder do
    # ⟦𓂫𓏩𓊗𓋷⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do
      contents =
        []
        |> then(& this.id && [{:id, this.id} | &1] || &1)
        |> then(& this.beacon && [{:beacon, this.beacon} | &1] || &1)
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> then(& this.target_vectors && [{:targetVectors, this.target_vectors} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}" end)
        |> Enum.join(",\n  ")
      """
      nearObject: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
