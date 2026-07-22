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

  # ⟦𓉡𓌋𓎨𓏆⟧ where :: auto-generated pointer for public function where
  def where(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | where: value}
  end

  # ⟦𓅏𓂚𓎢𓃉⟧ group_by :: auto-generated pointer for public function group_by
  def group_by(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) when is_list(value) do
    %{this | group_by: value}
  end

  # ⟦𓁬𓆭𓄦𓁥⟧ near_text :: auto-generated pointer for public function near_text
  def near_text(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | near_text: value}
  end

  # ⟦𓎫𓅁𓇪𓈼⟧ near_vector :: auto-generated pointer for public function near_vector
  def near_vector(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | near_vector: value}
  end

  # ⟦𓇇𓋭𓈽𓐊⟧ near_object :: auto-generated pointer for public function near_object
  def near_object(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | near_object: value}
  end

  # ⟦𓂷𓌽𓋝𓁠⟧ object_limit :: auto-generated pointer for public function object_limit
  def object_limit(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | object_limit: value}
  end

  # ⟦𓃷𓁠𓌅𓈲⟧ limit :: auto-generated pointer for public function limit
  def limit(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | limit: value}
  end

  # ⟦𓅱𓇠𓌆𓌩⟧ tenant :: auto-generated pointer for public function tenant
  def tenant(%Noizu.Weaviate.GraphQL.Aggregate{} = this, value) do
    %{this | tenant: value}
  end

  @doc """
  Add a field specification for aggregation.

  Example:
    field(agg, %{name: "wordCount", type: :int, aggregations: [:count, :mean, :maximum]})
  """
  # ⟦𓍳𓎈𓆢𓁗⟧ field :: Add a field specification for aggregation.
  def field(%Noizu.Weaviate.GraphQL.Aggregate{} = this, field_spec) do
    update_in(this, [Access.key(:fields)], &([field_spec | &1]))
  end

  @doc """
  Add meta { count } to the aggregate query.
  """
  # ⟦𓌨𓎱𓋻𓇤⟧ meta_count :: Add meta { count } to the aggregate query.
  def meta_count(%Noizu.Weaviate.GraphQL.Aggregate{} = this) do
    field(this, %{name: :meta, type: :meta, aggregations: [:count]})
  end

  @doc false
  # ⟦𓅷𓇆𓐑𓄃⟧ render_aggregation :: auto-generated pointer for public function render_aggregation
  def render_aggregation(:topOccurrences), do: "topOccurrences { value occurs }"
  def render_aggregation({:topOccurrences, limit}), do: "topOccurrences(limit: #{limit}) { value occurs }"
  def render_aggregation(:pointingTo), do: "pointingTo"
  def render_aggregation(:groupedBy), do: "groupedBy { path value }"
  def render_aggregation(agg), do: "#{agg}"

  @doc false
  # ⟦𓍝𓆱𓁂𓅼⟧ render_field :: auto-generated pointer for public function render_field
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

    # ⟦𓀛𓉖𓀩𓈿⟧ encode :: auto-generated pointer for public function encode
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
