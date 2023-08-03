defmodule WeaviateStructs.Node do
  @moduledoc """
  Structs for storing information about nodes.
  """

  defstruct name: "", status: "", version: "", gitHash: "", stats: %{}
end
