defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearVector do
  defstruct [
    vector: nil,
    distance: nil,
    certainty: nil
  ]


  def filter(container, vector, options \\ nil) do
    operator = %__MODULE__{
      vector: vector,
      distance: options[:distance],
      certainty: options[:certainty]
    }
    container.__struct__.search_operator(container, operator)
  end


  defimpl Jason.Encoder do

    def encode(this, opts) do
      contents =
        []
        |> then(& [{:vector, this.vector} | &1])
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}: #{inspect v}" end)
        |> Enum.join(",\n  ")
      """
      nearVector: {
        #{contents}
      }
      """ |> String.trim()
    end
  end

end
