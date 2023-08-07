defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearObject do
  defstruct [
    id: nil,
    beacon: nil,
    distance: nil,
    certainty: nil
  ]


  def filter(container, resource, options \\ nil) do
    {id, beacon} = cond do
      String.starts_with?(resource, "weaviate://") -> {nil, resource}
      :else -> {resource, nil}
    end

    operator = %__MODULE__{
      id: id,
      beacon: beacon,
      distance: options[:distance],
      certainty: options[:certainty]
    }
    container.__struct__.search_operator(container, operator)
  end


  defimpl Jason.Encoder do
    def encode(this, opts) do
      contents =
        []
        |> then(& this.id && [{:id, this.id} | &1] || &1)
        |> then(& this.beacon && [{:beacon, this.beacon} | &1] || &1)
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{inspect v}" end)
        |> Enum.join(",\n  ")
      """
      nearObject: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
