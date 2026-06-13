defmodule Noizu.Weaviate.GraphQL.SearchOperator.Hybrid do
  defstruct [
    query: nil,
    alpha: nil,
    vector: nil,
    properties: nil,
    fusion_type: nil,
    target_vectors: nil,
    bm25_search_operator: nil
  ]


  def filter(container, query, options \\ nil) do
    properties = case options[:properties] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    target_vectors = case options[:target_vectors] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    operator = %__MODULE__{
      query: query,
      alpha: options[:alpha],
      vector: options[:vector],
      properties: properties,
      fusion_type: options[:fusion_type],
      target_vectors: target_vectors,
      bm25_search_operator: options[:bm25_search_operator]
    }
    container.__struct__.search_operator(container, operator)
  end



  defimpl Jason.Encoder do
    def encode(this, opts) do
      contents =
        []
        |> then(& this.query && [{:query, this.query} | &1] || &1)
        |> then(& this.alpha && [{:alpha, this.alpha} | &1] || &1)
        |> then(& this.vector && [{:vector, this.vector} | &1] || &1)
        |> then(& this.properties && [{:properties, this.properties} | &1] || &1)
        |> then(& this.fusion_type && [{:fusionType, this.fusion_type} | &1] || &1)
        |> then(& this.target_vectors && [{:targetVectors, this.target_vectors} | &1] || &1)
        |> then(& this.bm25_search_operator && [{:bm25SearchOperator, this.bm25_search_operator} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}" end)
        |> Enum.join(",\n  ")
      """
      hybrid: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
