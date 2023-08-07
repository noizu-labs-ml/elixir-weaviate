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
        |> then(& this.path && [{:path, this.path} | &1] || &1)
        |> then(& this.groups && [{:groups, this.groups} | &1] || &1)
        |> then(& this.objects_per_group && [{:objectsPerGroup, this.objects_per_group} | &1] || &1)
        |> Enum.map(fn
          {k,v} -> "#{k}: #{inspect v}"
          {k} -> k
        end)
        |> Enum.join(",\n")
      encoded = """
                groupBy: {
                  #{nest(contents, "  ")}
                }
                """ |> String.trim()
      {:ok, encoded}
    end
  end

end
