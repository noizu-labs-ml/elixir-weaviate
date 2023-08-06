defmodule Noizu.Weaviate.Struct.Property do
  defstruct [
    :data_type,
    :description,
    :name,
    :index_filterable,
    :index_searchable,
    :index_inverted,
    :tokenization,
    :module_config
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      data_type: json[:dataType],
      description: json[:description],
      name: json[:name],
      index_filterable: json[:indexFilterable],
      index_searchable: json[:indexSearchable],
      index_inverted: json[:indexInverted],
      tokenization: json[:tokenization],
      module_config: json[:moduleConfig],
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        dataType: this.data_type,
        description: this.description,
        name: this.name,
        indexFilterable: this.index_filterable,
        indexSearchable: this.index_searchable,
        indexInverted: this.index_inverted,
        tokenization: this.tokenization,
        moduleConfig: this.module_config
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
