defmodule Noizu.Weaviate.GraphQL.SearchOperator.Group do
  defstruct [
    type: nil,
    force: nil,
  ]

  def filter(container, type, force) do

    operator = %__MODULE__{
      type: type,
      force: force
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
        |> then(& this.type && [{:type, this.type} | &1] || &1)
        |> then(& this.force && [{:force, this.force} | &1] || &1)
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
