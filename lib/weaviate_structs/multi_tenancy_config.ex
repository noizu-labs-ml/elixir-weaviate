defmodule Noizu.Weaviate.Struct.MultiTenancyConfig do
  defstruct [
    :enabled,
    :auto_tenant_creation,
    :auto_tenant_activation
  ]

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
