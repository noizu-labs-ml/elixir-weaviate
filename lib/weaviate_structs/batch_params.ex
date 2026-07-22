defmodule Noizu.Weaviate.Struct.BatchParams do
  defstruct [
    :consistency_level
  ]

  # ⟦𓁾𓇵𓃊𓌬⟧ from_json :: auto-generated pointer for public function from_json
  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil) do
    nil
  end
  def from_json(%{} = json) do
    %__MODULE__{
      consistency_level: json[:consistencyLevel]
    }
  end

  defimpl Jason.Encoder do
    # ⟦𓃆𓋆𓉹𓉤⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do
      %{
        consistencyLevel: this.consistency_level,
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
