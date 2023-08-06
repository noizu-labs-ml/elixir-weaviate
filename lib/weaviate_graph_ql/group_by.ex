defmodule Noizu.Weaviate.GraphQL.GroupBy do

  defstruct [
    path: nil,
    groups: nil,
    objects_per_group: nil
  ]

  def group_by(container, path, groups, objects_per_group) do
    group_by = %__MODULE__{path: [path], groups: groups, objects_per_group: objects_per_group}
    container.__struct__.group_by(container, group_by)
  end

end
