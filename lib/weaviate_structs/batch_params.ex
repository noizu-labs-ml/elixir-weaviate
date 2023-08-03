defmodule WeaviateStructs.BatchParams do
  @moduledoc """
  Struct for representing batch parameters in Weaviate.
  """

  defstruct [:consistency_level]

  @enforce_keys []

  @type t :: %__MODULE__{
    consistency_level: String.t()
  }
end
