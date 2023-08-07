defmodule Noizu.Weaviate.GraphQL.Get do
  defstruct [
    class: nil,
    limit: nil,
    offset: nil,
    after_call: nil,
    include: nil,
    sort: nil,
    order: nil,

    consistency_level: nil, # ONE, QUORUM, ALL
    search_operator: nil, # nearObject nearVector nearText nearImage hybrid bm25 ask group
    where: nil,
    group: nil,



    group_by: nil,

    autocut: nil,
    sort: nil, # {path: [], order: asc | desc}
    additional: nil,
    properties: []
  ]

  def consistency_level(%Noizu.Weaviate.GraphQL.Get{} = this, level) when level in [:one, :quorum, :all] do
    %{this| consistency_level: level}
  end

  def additional(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| additional: value}
  end

  def search_operator(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| search_operator: value}
  end

  def group_by(%Noizu.Weaviate.GraphQL.Get{} = this, %Noizu.Weaviate.GraphQL.GroupBy{} = group_by) do
    %{this| group_by: group_by}
  end

  def limit(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| limit: value}
  end

  def offset(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| offset: value}
  end

  def after_call(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| after_call: value}
  end

  def autocut(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| autocut: value}
  end

  def sort(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| sort: value}
  end

  def where(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| where: value}
  end

  def property(%Noizu.Weaviate.GraphQL.Get{} = this, property) do
    update_in(this, [Access.key(:properties)], &([property|&1]))
  end

  def properties(%Noizu.Weaviate.GraphQL.Get{} = this, properties) when is_list(properties) do
    update_in(this, [Access.key(:properties)], &(properties ++ &1))
  end


  defimpl Jason.Encoder do
    defp nest(string, prefix) do
      prepared = String.trim(string)
                 |> String.split("\n")
                 |> Enum.join("\n#{prefix}")
      prepared
    end

    def encode(this, opts) do

      class_attributes =
        []
        |> then(& this.limit && [{:limit, this.limit}|&1] || &1)
        |> then(& this.offset && [{:offset, this.offset}|&1] || &1)
        |> then(& this.after_call && [{:after, this.after_call}|&1] || &1)
        |> then(& this.include && [{:include, this.include}|&1] || &1)
        |> then(& this.sort && [{:sort, this.sort}|&1] || &1)
        |> then(& this.order && [{:order, this.order}|&1] || &1)
        |> then(& this.consistency_level && ["consistencyLevel: #{this.consistency_level}"|&1] || &1)
        |> then(& this.where && ["where: #{nest(Jason.encode!(this.where) , "  ")}"|&1] || &1)
        |> then(& this.autocut && [{:autocut, this.autocut}|&1] || &1)
        |> then(& this.search_operator && [Jason.encode!(this.search_operator)|&1] || &1)
        |> Enum.map(fn
          ({k,v}) -> "#{k}: #{inspect v}"
          (k) -> k
          end
        )
        |> Enum.join(",\n")
        |> case do
            "" -> nil
            v -> v
         end

      properties = Enum.map(this.properties, fn(property) ->
        case property do
          v when is_bitstring(v) -> v
        end
      end) |> Enum.join("\n")

      additional = this.additional && Jason.encode!(this.additional) || nil

      query = if class_attributes do
        """
        {
          Get {
            #{this.class} (
               #{nest(class_attributes, "       ")}
            ) {
               #{nest(properties, "       ")}#{additional && "\n       " <> nest(additional, "       ") || ""}
            }
          }
        }
        """
      else
        """
        {
          Get {
            #{this.class} {
               #{nest(properties, "       ")}#{additional && "\n       " <> nest(additional, "       ") || ""}
            }
          }
        }
        """
      end |> String.trim()

      """
      {\"query\": #{inspect(query)}}
      """ |> String.trim()
    end
  end

end
