defmodule Noizu.Weaviate.GraphQL.SearchOperator do

  defmodule NearVector do
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
  end


  defmodule NearObject do
    defstruct [
      id: nil,
      beacon: nil,
      distance: nil,
      certainty: nil
    ]


    def filter(container, id, beacon, options \\ nil) do
      operator = %__MODULE__{
        id: id,
        beacon: beacon,
        distance: options[:distance],
        certainty: options[:certainty]
      }
      container.__struct__.search_operator(container, operator)
    end
  end


  defmodule Hybrid do
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
  end


  defmodule BM25 do
    defstruct [
      query: nil,
      properties: nil,
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
      }
      container.__struct__.search_operator(container, operator)
    end
  end


  defmodule NearText do

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
  end


  defmodule Ask do
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
  end

end
