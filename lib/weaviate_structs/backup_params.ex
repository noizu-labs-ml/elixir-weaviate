defmodule WeaviateStructs.BackupParams do
  @moduledoc """
  Struct for representing backup parameters in Weaviate.
  """

  defstruct [:backend, :id, :include, :exclude]

  @enforce_keys [:backend, :id]

  @type t :: %__MODULE__{
    backend: String.t(),
    id: String.t(),
    include: list(String.t()),
    exclude: list(String.t())
  }
end
