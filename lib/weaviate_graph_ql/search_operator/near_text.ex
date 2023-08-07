defmodule Noizu.Weaviate.GraphQL.SearchOperator.NearText do

  defmodule Concepts do
    defstruct [
      concepts: nil,
      force: nil
    ]
  end

  defmodule Objects do
    defstruct [
      objects: nil,
      force: nil
    ]
  end

  defstruct [
    concepts: nil,
    certainty: nil,
    distance: nil,
    autocorrect: nil,
    move_to: nil,
    move_to__concepts: nil,
    move_to__objects: nil,

    move_away_from: nil,
    move_away_from__concepts: nil,
    move_away_from__objects: nil,
    move_away_from__force: nil,
  ]

  defp from_option(nil), do: nil
  defp from_options(options) do
    concepts = case options[:concepts] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
      _ -> nil
    end

    objects = case options[:objects] do
      v when is_bitstring(v) -> [%{id: v}]
      v when is_list(v) ->
        Enum.map(v, fn(obj) ->
          case obj do
            v when is_bitstring(v) -> %{id: v}
          end
        end)
      _ -> nil
    end

    cond do
      concepts ->
        %Concepts{
          concepts: concepts,
          force: options[:force]
        }
      objects ->
        %Objects{
          objects: objects,
          force: options[:force]
        }
      :else -> nil
    end
  end


  def filter(container, concepts, options \\ nil) do
    concepts = case options[:concepts] do
      v when is_bitstring(v) -> [v]
      v when is_list(v) -> v
    end
    move_to__concepts = case options[:"move_to{concepts}"] do
      nil -> nil
      v when is_list(v) -> v
      v -> [v]
    end
    move_to__objects = case options[:"move_to{objects}"] do
      nil -> nil
      v when is_list(v) -> v
      v -> [v]
    end
    move_away_from__concepts = case options[:"move_away_from{concepts}"] do
      nil -> nil
      v when is_list(v) -> v
      v -> [v]
    end
    move_away_from__objects = case options[:"move_away_from{objects}"] do
      nil -> nil
      v when is_list(v) -> v
      v -> [v]
    end

    operator = %__MODULE__{
      concepts: concepts,
      certainty: options[:certainty],
      distance: options[:distance],
      autocorrect: options[:autocorrect],
      move_to: from_options(options[:move_to]),
      move_to__concepts: move_to__concepts,
      move_to__objects: move_to__objects,

      move_away_from: from_options(options[:move_away_from]),
      move_away_from__concepts: move_away_from__concepts,
      move_away_from__objects: move_away_from__objects,
      move_away_from__force: options[:"move_away_from{force}"],
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
        |> then(& this.concepts && [{:concepts, this.concepts} | &1] || &1)
        |> then(& this.distance && [{:distance, this.distance} | &1] || &1)
        |> then(& this.autocorrect in [true, false] && [{:autocorrect, this.autocorrect} | &1] || &1)
        |> then(& this.move_to && ["move_to: #{Jason.encode!(this.move_to)}" | &1] || &1)
        |> then(& this.move_to__concepts && [{:"moveTo{concepts}", this.move_to__concepts} | &1] || &1)
        |> then(& this.move_to__objects && [{:"moveTo{objects}", this.move_to__objects} | &1] || &1)
        |> then(& this.move_away_from && ["moveAwayFrom: #{Jason.encode!(this.move_away_from)}" | &1] || &1)
        |> then(& this.move_away_from__concepts && [{:"moveAwayFrom{concepts}", this.move_away_from__concepts} | &1] || &1)
        |> then(& this.move_away_from__objects && [{:"moveAwayFrom{objects}", this.move_away_from__objects} | &1] || &1)
        |> then(& this.move_away_from__force && [{:"moveAwayFrom{force}", this.move_away_from__force} | &1] || &1)
        |> Enum.map(fn
          {k,v} -> "#{k}: #{inspect v}"
          {k} -> k
        end)
        |> Enum.join(",\n")
      """
      nearText: {
        #{nest(contents, "  ")}
      }
      """ |> String.trim()
    end
  end

end
