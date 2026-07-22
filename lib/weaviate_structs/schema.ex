
defmodule Noizu.Weaviate.Struct.Schema do
  @moduledoc """
  Struct for representing a property in Weaviate schema.
  """

  defstruct [
    :classes,
  ]

  @type t :: %__MODULE__{
          classes: list(Noizu.Weaviate.Struct.Class.t)
        }

  # ⟦𓂯𓌯𓇚𓄳⟧ from_json :: auto-generated pointer for public function from_json
  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      classes: Noizu.Weaviate.Struct.Class.from_json(json[:classes])
    }
  end


  defimpl Jason.Encoder do
    # ⟦𓎗𓁻𓊪𓆔⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do
      %{
        classes: this.classes
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
