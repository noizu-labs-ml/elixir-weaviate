defmodule Noizu.Weaviate.GraphQL.Aggregate do
  defstruct [
    class: nil,
    where: nil,
    group_by: nil,
    near_text: nil,
    near_vector: nil,
    near_object: nil,
    object_limit: nil,
    limit: nil,
    tenant: nil,
    fields: []
  ]

  def where(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | where: value}
  end

  def group_by(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) when is_list(value) do
    %{this | group_by: value}
  end

  def near_text(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | near_text: value}
  end

  def near_vector(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | near_vector: value}
  end

  def near_object(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | near_object: value}
  end

  def object_limit(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | object_limit: value}
  end

  def limit(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | limit: value}
  end

  def tenant(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | tenant: value}
  end

  @doc """
  Add a field specification for aggregation.

  Example:
    field(agg, %{name: "wordCount", type: :int, aggregations: [:count, :mean, :maximum]})
  """
  def field(%Noizu.Weaviate.GraphQL.Aggregate{} = this, field_spec) do
    update_in(this, [Access.key(:fields)], &([field_spec | &1]))
  end

  @doc """
  Add meta { count } to the aggregate query.
  """
  def meta_count(%Noizu.Weaviate.GraphQL.Aggregate{} = this) do
    field(this, %{name: :meta, type: :meta, aggregations: [:count]})
  end

  @doc false
  def render_aggregation(:topOccurrences), do: "topOccurrences { value occurs }"
  def render_aggregation({:topOccurrences, limit}), do: "topOccurrences(limit: #{limit}) { value occurs }"
  def render_aggregation(:pointingTo), do: "pointingTo"
  def render_aggregation(:groupedBy), do: "groupedBy { path value }"
  def render_aggregation(agg), do: "#{agg}"

  @doc false
  def render_field(%{name: :meta, type: :meta, aggregations: aggs}) do
    inner = Enum.map(aggs, &render_aggregation/1) |> Enum.join(" ")
    "meta { #{inner} }"
  end
  def render_field(%{name: name, aggregations: aggs}) do
    inner = Enum.map(aggs, &render_aggregation/1) |> Enum.join(" ")
    "#{name} { #{inner} }"
  end

  defimpl Jason.Encoder do
    defp nest(string, prefix) do
      prepared = String.trim(string)
                 |> String.split("\n")
                 |> Enum.join("\n#{prefix}")
      prepared
    end

    def encode(this, _opts) do
      class = case this.class do
        v when is_bitstring(v) -> v
        v when is_atom(v) -> v.__class__
      end

      class_attributes =
        []
        |> then(& this.where && ["where: #{nest(Jason.encode!(this.where), "  ")}" | &1] || &1)
        |> then(& this.near_text && [Jason.encode!(this.near_text) | &1] || &1)
        |> then(& this.near_vector && [Jason.encode!(this.near_vector) | &1] || &1)
        |> then(& this.near_object && [Jason.encode!(this.near_object) | &1] || &1)
        |> then(& this.group_by && ["groupBy: #{inspect(this.group_by)}" | &1] || &1)
        |> then(& this.object_limit && [{:objectLimit, this.object_limit} | &1] || &1)
        |> then(& this.limit && [{:limit, this.limit} | &1] || &1)
        |> then(& this.tenant && ["tenant: #{inspect(this.tenant)}" | &1] || &1)
        |> Enum.map(fn
          ({k, v}) -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}"
          (k) -> k
        end)
        |> Enum.join(",\n")
        |> case do
          "" -> nil
          v -> v
        end

      fields = this.fields
               |> Enum.reverse()
               |> Enum.map(&Noizu.Weaviate.GraphQL.Aggregate.render_field/1)

      # Add groupedBy output when group_by is set
      fields = if this.group_by do
        fields ++ ["groupedBy { path value }"]
      else
        fields
      end

      fields_str = Enum.join(fields, "\n")

      query = if class_attributes do
        """
        {
          Aggregate {
            #{class} (
               #{nest(class_attributes, "       ")}
            ) {
               #{nest(fields_str, "       ")}
            }
          }
        }
        """
      else
        """
        {
          Aggregate {
            #{class} {
               #{nest(fields_str, "       ")}
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
