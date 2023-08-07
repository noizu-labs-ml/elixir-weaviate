defmodule Noizu.Weaviate.GraphQL.SearchOperator.Hybrid do
  defstruct [
    query: nil,
    alpha: nil,
    vector: nil,
    properties: nil,
    fusion_type: nil
  ]


  def filter(container, query, options \\ nil) do
    properties = case options[:properties] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end
    operator = %__MODULE__{
      query: query,
      alpha: options[:alpha],
      vector: options[:vector],
      properties: properties,
      fusion_type: options[:fusion_type]
    }
    container.__struct__.search_operator(container, operator)
  end



  defimpl Jason.Encoder do
    def encode(this, opts) do
      contents =
        []
        |> then(& this.query && [{:id, this.query} | &1] || &1)
        |> then(& this.alpha && [{:beacon, this.alpha} | &1] || &1)
        |> then(& this.vector && [{:distance, this.vector} | &1] || &1)
        |> then(& this.properties && [{:properties, this.properties} | &1] || &1)
        |> then(& this.fusion_type && [{:fusionType, this.fusion_type} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{inspect v}" end)
        |> Enum.join(",\n  ")
      """
      hybrid: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
