defmodule Noizu.Weaviate.GraphQL.Get do
  defstruct [
    class: nil,
    consistency_level: nil, # ONE, QUORUM, ALL
    search_operator: nil, # nearObject nearVector nearText nearImage hybrid bm25 ask group
    where: nil,
    group: nil,

    group_by: nil,
    limit: nil,
    offset: nil,
    after: nil,
    autocut: nil,
    sort: nil, # {path: [], order: asc | desc}
    additional: nil,
    properties: []
  ]

  def consistency_level(%Noizu.Weaviate.GraphQL.Get{} = this, level) when level in [:one, :quorum, :all] do
    %{this| consistency_level: level}
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
    %{this| after: value}
  end

  def autocut(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| autocut: value}
  end

  def sort(%Noizu.Weaviate.GraphQL.Get{} = this, value) do
    %{this| sort: value}
  end

  def property(%Noizu.Weaviate.GraphQL.Get{} = this, property) do
    update_in(this, [Access.key(:properties)], &([property|&1]))
  end

end
