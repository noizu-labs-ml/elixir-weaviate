defmodule Noizu.Weaviate.GraphQL.SearchOperator.BM25 do
  defstruct [
    query: nil,
    properties: nil,
    search_operator: nil
  ]


  def filter(container, query, options \\ nil) do
    properties = case options[:properties] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    operator = %__MODULE__{
      query: query,
      properties: properties,
      search_operator: options[:search_operator]
    }
    container.__struct__.search_operator(container, operator)
  end



  defimpl Jason.Encoder do
    def encode(this, opts) do
      contents =
        []
        |> then(& this.query && [{:query, this.query} | &1] || &1)
        |> then(& this.properties && [{:properties, this.properties} | &1] || &1)
        |> then(& this.search_operator && [{:searchOperator, this.search_operator} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}" end)
        |> Enum.join(",\n  ")
      """
      bm25: {
        #{contents}
      }
      """ |> String.trim()
    end
  end
end
