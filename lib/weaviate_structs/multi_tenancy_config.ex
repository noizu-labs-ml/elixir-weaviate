defmodule Noizu.Weaviate.Struct.MultiTenancyConfig do
  defstruct [
    :enabled,
    :auto_tenant_creation,
    :auto_tenant_activation
  ]

  # ⟦𓎄𓂘𓋽𓄐⟧ from_json :: auto-generated pointer for public function from_json
  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      enabled: json[:enabled],
      auto_tenant_creation: json[:autoTenantCreation],
      auto_tenant_activation: json[:autoTenantActivation]
    }
  end

  defimpl Jason.Encoder do
    # ⟦𓂏𓃄𓃋𓍿⟧ encode :: auto-generated pointer for public function encode
    def encode(this, opts) do
      %{
        enabled: this.enabled,
        autoTenantCreation: this.auto_tenant_creation,
        autoTenantActivation: this.auto_tenant_activation
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
