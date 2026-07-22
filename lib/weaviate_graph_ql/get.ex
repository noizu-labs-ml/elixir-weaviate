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
    tenant: nil,

    autocut: nil,
    sort: nil, # {path: [], order: asc | desc}
    additional: nil,
    properties: []
  ]

  # ⟦𓐜𓍚𓅰𓇀⟧ consistency_level :: auto-generated pointer for public function consistency_level
  def consistency_level(%Noizu.Weaviate.GraphQL.Get{} = this, level) when level in [:one, :quorum, :all] do
    %{this| consistency_level: level}
  end

  # ⟦𓅈𓃀𓊨𓀩⟧ additional :: auto-generated pointer for public function additional
  def additional(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| additional: value}
  end

  # ⟦𓋿𓂜𓅾𓂴⟧ search_operator :: auto-generated pointer for public function search_operator
  def search_operator(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| search_operator: value}
  end

  # ⟦𓇞𓋸𓈓𓐠⟧ group_by :: auto-generated pointer for public function group_by
  def group_by(%Noizu.Weaviate.GraphQL.Get{} = this, %Noizu.Weaviate.GraphQL.GroupBy{} = group_by) do
    %{this| group_by: group_by}
  end

  # ⟦𓈂𓎘𓏚𓃱⟧ limit :: auto-generated pointer for public function limit
  def limit(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| limit: value}
  end

  # ⟦𓂾𓎜𓂊𓃅⟧ offset :: auto-generated pointer for public function offset
  def offset(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| offset: value}
  end

  # ⟦𓌑𓅺𓂥𓁡⟧ after_call :: auto-generated pointer for public function after_call
  def after_call(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| after_call: value}
  end

  # ⟦𓍮𓍯𓂣𓏉⟧ autocut :: auto-generated pointer for public function autocut
  def autocut(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| autocut: value}
  end

  # ⟦𓌃𓇐𓄺𓂫⟧ sort :: auto-generated pointer for public function sort
  def sort(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| sort: value}
  end

  # ⟦𓐤𓊄𓊮𓏸⟧ where :: auto-generated pointer for public function where
  def where(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| where: value}
  end

  # ⟦𓎌𓁙𓆟𓂩⟧ tenant :: auto-generated pointer for public function tenant
  def tenant(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| tenant: value}
  end

  # ⟦𓇝𓆝𓆄𓏥⟧ property :: auto-generated pointer for public function property
  def property(%Noizu.Weaviate.GraphQL.Get{} = this, property) do
    update_in(this, [Access.key(:properties)], &([property|&1]))
  end

  # ⟦𓁴𓎼𓃧𓊿⟧ properties :: auto-generated pointer for public function properties
  def properties(%Noizu.Weaviate.GraphQL.Get{} = this, properties) when is_list(properties) do
    update_in(this, [Access.key(:properties)], &(properties ++ &1))
  end


  defimpl Jason.Encoder do
    defp encode_sort(%{path: path, order: order}) do
      path_str = inspect(path)
      "{path: #{path_str}, order: #{order}}"
    end
    defp encode_sort(%{path: path}) do
      path_str = inspect(path)
      "{path: #{path_str}}"
    end

    defp nest(string, prefix) do
      prepared = String.trim(string)
                 |> String.split("\n")
                 |> Enum.join("\n#{prefix}")
      prepared
    end

    # ⟦𓃝𓊽𓊲𓋠⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do

      class_attributes =
        []
        |> then(& this.limit && [{:limit, this.limit}|&1] || &1)
        |> then(& this.offset && [{:offset, this.offset}|&1] || &1)
        |> then(& this.after_call && [{:after, this.after_call}|&1] || &1)
        |> then(& this.include && [{:include, this.include}|&1] || &1)
        |> then(fn acc ->
          case this.sort do
            nil -> acc
            sorts when is_list(sorts) ->
              encoded = Enum.map(sorts, &encode_sort/1) |> Enum.join(", ")
              ["sort: [#{encoded}]" | acc]
            sort when is_map(sort) ->
              ["sort: [#{encode_sort(sort)}]" | acc]
          end
        end)
        |> then(& this.order && [{:order, this.order}|&1] || &1)
        |> then(& this.tenant && ["tenant: #{inspect(this.tenant)}"|&1] || &1)
        |> then(& this.consistency_level && ["consistencyLevel: #{this.consistency_level}"|&1] || &1)
        |> then(& this.where && ["where: #{nest(Jason.encode!(this.where) , "  ")}"|&1] || &1)
        |> then(& this.autocut && [{:autocut, this.autocut}|&1] || &1)
        |> then(& this.search_operator && [Jason.encode!(this.search_operator)|&1] || &1)
        |> Enum.map(fn
          ({k,v}) -> "#{k}: #{Noizu.Weaviate.GraphQL.encode_value(v)}"
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

      class = case this.class do
        v when is_bitstring(v) -> v
        v when is_atom(v) -> v.__class__
      end

      query = if class_attributes do
        """
        {
          Get {
            #{class} (
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
            #{class} {
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
