defmodule Noizu.Weaviate.GraphQL do

  def get(class) do
    %Noizu.Weaviate.GraphQL.Get{class: class}
  end

  #    consistency_level: nil, # ONE, QUORUM, ALL
  #    search_operator: nil, # nearObject nearVector nearText nearImage hybrid bm25 ask group
  #    group_by: nil,
  #    limit: nil,
  #    offset: nil,
  #    after: nil,
  #    autocut: nil,
  #    sort: nil, # {path: [], order: asc | desc}
  #    additional: nil,
  #    properties: []

  def consistency_level(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.consistency_level(container, value)
  end

  def search_operator(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.search_operator(container, value)
  end

  def group_by(%Noizu.Weaviate.GraphQL.Get{} = container, path, groups, objects_per_group) do
    Noizu.Weaviate.GraphQL.GroupBy.group_by(container, path, groups, objects_per_group)
  end

  def limit(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.limit(container, value)
  end

  def offset(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.offset(container, value)
  end

  def after_call(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.after_call(container, value)
  end

  def autocut(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.autocut(container, value)
  end

  def sort(%Noizu.Weaviate.GraphQL.Get{} = container, value) do
    Noizu.Weaviate.GraphQL.Get.sort(container, value)
  end

  def property(%Noizu.Weaviate.GraphQL.Get{} = get, property) do
    Noizu.Weaviate.GraphQL.Get.property(get, property)
  end

  def where(container, clause), do: Noizu.Weaviate.GraphQL.Where.where(container, clause)

end
