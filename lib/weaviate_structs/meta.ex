defmodule WeaviateStructs.Meta do
  defstruct [
    :hostname,
    :version,
    :modules
  ]

  def from_json(%{
    "hostname" => hostname,
    "version" => version,
    "modules" => modules
  }) do
    %__MODULE__{
      hostname: hostname,
      version: version,
      modules: modules
    }
  end
end
