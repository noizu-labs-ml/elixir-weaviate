defmodule WeaviateStructs.Meta do
  @moduledoc """
  Structs for storing meta information.
  """

  defmodule Hostname do
    defstruct name: ""
  end

  defmodule Version do
    defstruct version: "", modules: %{}
  end
end
