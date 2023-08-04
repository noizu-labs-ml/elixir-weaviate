
defmodule WeaviateStructs.OpenIDConfiguration do
  defstruct [
    :href,
    :clientID
  ]

  def from_json(%{
    "href" => href,
    "clientID" => clientID
  }) do
    %__MODULE__{
      href: href,
      clientID: clientID
    }
  end
end
