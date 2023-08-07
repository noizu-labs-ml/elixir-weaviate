defmodule Noizu.Weaviate.GraphQL.SearchOperator.Ask do
  defstruct [
    question: nil,
    certainty: nil,
    properties: nil,
    rerank: nil
  ]

  def filter(container, question, options \\ nil) do

    properties = case options[:properties] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end

    operator = %__MODULE__{
      question: question,
      certainty: options[:certainty],
      properties: properties,
      rerank: options[:rerank]
    }
    container.__struct__.search_operator(container, operator)
  end


  defimpl Jason.Encoder do
    defp nest(string, prefix) do
      prepared = String.trim(string)
                 |> String.split("\n")
                 |> Enum.join("\n#{prefix}")
      prepared
    end

    def encode(this, opts) do
      contents =
        []
        |> then(& this.question && [{:question, this.question} | &1] || &1)
        |> then(& this.certainty && [{:certainty, this.certainty} | &1] || &1)
        |> then(& this.properties && [{:properties, this.properties} | &1] || &1)
        |> then(& this.rerank in [true, false] && [{:rerank, this.rerank} | &1] || &1)
        |> Enum.map(fn
          {k,v} -> "#{k}: #{inspect v}"
          {k} -> k
        end)
        |> Enum.join(",\n")
      """
      ask: {
        #{nest(contents, "  ")}
      }
      """ |> String.trim()
    end
  end
end
