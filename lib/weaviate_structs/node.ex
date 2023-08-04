defmodule WeaviateStructs.Node do
  @moduledoc """
  Structs for storing information about nodes.
  """

  defstruct name: "", status: "", version: "", gitHash: "", stats: %{}

  def from_json(%{
    "name" => name,
    "status" => status,
    "version" => version,
    "gitHash" => gitHash,
    "stats" => stats
  }) do
    %__MODULE__{
      name: name,
      status: status,
      version: version,
      gitHash: gitHash,
      stats: stats
    }
  end

end
