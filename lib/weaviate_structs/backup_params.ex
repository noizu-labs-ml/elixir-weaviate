defmodule WeaviateStructs.BackupParams do
  defstruct [
    :backend,
    :id,
    :include,
    :exclude
  ]

  def from_json(%{
    "backend" => backend,
    "id" => id,
    "include" => include,
    "exclude" => exclude
  }) do
    %__MODULE__{
      backend: backend,
      id: id,
      include: include,
      exclude: exclude
    }
  end
end
