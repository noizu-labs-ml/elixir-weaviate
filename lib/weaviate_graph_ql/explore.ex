defmodule Noizu.Weaviate.GraphQL.Explore do
  defstruct [
    near_text: nil,
    near_vector: nil,
    near_object: nil,
    limit: nil,
    offset: nil
  ]

  # ⟦𓋛𓌿𓐩𓐅⟧ near_text :: auto-generated pointer for public function near_text
  def near_text(%Noizu.Weaviate.GraphQL.Explore{} = this, value) do
    %{this | near_text: value}
  end

  # ⟦𓆿𓇒𓀋𓃙⟧ near_vector :: auto-generated pointer for public function near_vector
  def near_vector(%Noizu.Weaviate.GraphQL.Explore{} = this, value) do
    %{this | near_vector: value}
  end

  # ⟦𓍖𓋧𓇨𓋚⟧ near_object :: auto-generated pointer for public function near_object
  def near_object(%Noizu.Weaviate.GraphQL.Explore{} = this, value) do
    %{this | near_object: value}
  end

  # ⟦𓋢𓏜𓎟𓁓⟧ limit :: auto-generated pointer for public function limit
  def limit(%Noizu.Weaviate.GraphQL.Explore{} = this, value) do
    %{this | limit: value}
  end

  # ⟦𓂸𓎱𓎹𓐎⟧ offset :: auto-generated pointer for public function offset
  def offset(%Noizu.Weaviate.GraphQL.Explore{} = this, value) do
    %{this | offset: value}
  end

  defimpl Jason.Encoder do
    defp nest(string, prefix) do
      prepared = String.trim(string)
                 |> String.split("\n")
                 |> Enum.join("\n#{prefix}")
      prepared
    end

    # ⟦𓈂𓉀𓌓𓋇⟧ encode :: auto-generated pointer for public function encode
    def encode(this, _opts) do
      class_attributes =
        []
        |> then(& this.near_text && [Jason.encode!(this.near_text) | &1] || &1)
        |> then(& this.near_vector && [Jason.encode!(this.near_vector) | &1] || &1)
        |> then(& this.near_object && [Jason.encode!(this.near_object) | &1] || &1)
        |> then(& this.limit && [{:limit, this.limit} | &1] || &1)
        |> then(& this.offset && [{:offset, this.offset} | &1] || &1)
        |> Enum.map(fn
          ({k, v}) -> "#{k}: #{inspect v}"
          (k) -> k
        end)
        |> Enum.join(",\n")
        |> case do
          "" -> nil
          v -> v
        end

      query = if class_attributes do
        """
        {
          Explore (
             #{nest(class_attributes, "     ")}
          ) {
             beacon
             certainty
             distance
             className
          }
        }
        """
      else
        """
        {
          Explore {
             beacon
             certainty
             distance
             className
          }
        }
        """
      end |> String.trim()

      """
      {\"query\": #{inspect(query)}}
      """ |> String.trim()
    end
  end

end
