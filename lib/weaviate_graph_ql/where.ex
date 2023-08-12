defmodule Noizu.Weaviate.GraphQL.Where do

  @value_types [
    :value_int,
    :value_boolean,
    :value_string,
    :value_text,
    :value_number,
    :value_date
  ]

  @value_type_lookup %{
    int: :value_int,
    bool: :value_boolean,
    string: :value_string,
    text: :value_text,
    number: :value_number,
    date: :value_date
  }

  defstruct [
    operator: nil
  ]

  defimpl Jason.Encoder do
    defp nest(string, prefix) do
      prepared = String.trim(string)
                 |> String.split("\n")
                 |> Enum.join("\n#{prefix}")
      prepared
    end

    def encode(this, opts) do
      Jason.encode!(this.operator) |> String.trim()
    end
  end

  defmodule And do
    defstruct [
      operands: nil
    ]


    defimpl Jason.Encoder do
      defp nest(string, prefix) do
        prepared = String.trim(string)
                   |> String.split("\n")
                   |> Enum.join("\n#{prefix}")
        prepared
      end

      def encode(this, opts) do
        contents =
          this.operands
          |> Enum.map(fn
            {k} -> "#{nest(Jason.encode!(k), "  ")}"
          end)
          |> Enum.join(",\n")
        """
        {
          operator: And,
          operands: [
            #{nest(contents, "    ")}
          ]
        }
        """ |> String.trim()
      end
    end

  end

  defmodule Or do
    defstruct [
      operands: nil
    ]

    defimpl Jason.Encoder do
      defp nest(string, prefix) do
        prepared = String.trim(string)
                   |> String.split("\n")
                   |> Enum.join("\n#{prefix}")
        prepared
      end

      def encode(this, opts) do
        contents =
          this.operands
          |> Enum.map(fn
            {k} -> "#{nest(Jason.encode!(k), "  ")}"
          end)
          |> Enum.join(",\n")
        """
        {
          operator: Or,
          operands: [
            #{nest(contents, "    ")}
          ]
        }
        """ |> String.trim()
      end
    end
  end

  defmodule WithinGeoRange do
    defstruct [
      coordinates: nil,
      distance: nil,
      path: nil
    ]


    defimpl Jason.Encoder do
      defp nest(string, prefix) do
        prepared = String.trim(string)
                   |> String.split("\n")
                   |> Enum.join("\n#{prefix}")
        prepared
      end

      def encode(this, opts) do
        contents =
          this.operands
          |> Enum.map(fn
            {k} -> "#{nest(Jason.encode!(k), "  ")}"
          end)
          |> Enum.join(",\n")
        """
        {
          operator: WithinGeoRange,
          valueGeoRange: {
            latitude: #{this.coordinates.latitude},
            longitude: #{this.coordinates.longitude},
          }
          distance: #{Jason.encode(this.distance) |> nest("  ")}
          path: #{inspect this.path}
        }
        """ |> String.trim()
      end
    end

  end

  defmodule Condition do
    defstruct [
      path: nil,
      operator: nil,
      value: nil,
      value_type: nil
    ]


    defimpl Jason.Encoder do
      defp nest(string, prefix) do
        prepared = String.trim(string)
                   |> String.split("\n")
                   |> Enum.join("\n#{prefix}")
        prepared
      end

      def encode(this, opts) do
        value_type = case this.value_type do
          :value_int -> "valueInt"
          :value_boolean -> "valueBoolean"
          :value_string -> "valueString"
          :value_text -> "valueText"
          :value_number -> "valueNumber"
          :value_date -> "valueDate"
        end
        """
        {
          operator: #{this.operator},
          #{value_type}: #{inspect(this.value)},
          path: #{inspect this.path}
        }
        """ |> String.trim()
      end
    end

  end

  def extract_path(path) do
    cond do
      is_bitstring(path) -> [path]
      is_list(path) -> path
    end
  end
  def extract_value_type(value) do
    cond do
      is_integer(value) -> :value_int
      is_bitstring(value) -> :value_string
      is_float(value) -> :value_number
      value in [true, false] -> :value_boolean
      is_struct(value) && value.__struct__ == DateTime -> :value_date
      is_struct(value) && value.__struct__ == Date -> :value_date
    end
  end
  def type_lookup(value_type) do
    @value_type_lookup[value_type]
  end


  def where(container, filter) do
    container.__struct__.where(container, %__MODULE__{operator: filter})
  end

  def and_operator(a,b) do
    %Noizu.Weaviate.GraphQL.Where.And{
      operands: [a,b]
    }
  end

  def or_operator(a,b) do
    %Noizu.Weaviate.GraphQL.Where.Or{
      operands: [a,b]
    }
  end

  def near(path, %{longitude: longitude, latitude: latitude}, distance) do
    %Noizu.Weaviate.GraphQL.Where.WithinGeoRange{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      coordinates: %{longitude: longitude, latitude: latitude},
      distance: distance
    }
  end

  def equal(path, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :Equal,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.extract_value_type(value)
    }
  end
  def equal(path, value_type, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :Equal,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end


  def not_equal(path, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :NotEqual,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.extract_value_type(value)
    }
  end
  def not_equal(path, value_type, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :NotEqual,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end

  def greater_than(path, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :GreaterThan,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.extract_value_type(value)
    }
  end
  def greater_than(path, value_type, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :GreaterThan,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end


  def greater_than_eq(path, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :GreaterThanEqual,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.extract_value_type(value)
    }
  end
  def greater_than_eq(path, value_type, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :GreaterThanEqual,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end


  def less_than(path, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :LessThan,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.extract_value_type(value)
    }
  end
  def less_than(path, value_type, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :LessThan,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end


  def less_than_eq(path, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :LessThanEqual,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.extract_value_type(value)
    }
  end
  def less_than_eq(path, value_type, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :LessThanEqual,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end


  def like(path, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :Like,
      value: value,
      value_type: :value_text
    }
  end
  def like(path, value_type, value) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :Like,
      value: value,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end



  def is_null(path) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :IsNull,
      value: true,
      value_type: :value_boolean
    }
  end

  def is_not_null(path) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :IsNull,
      value: false,
      value_type: :value_boolean
    }
  end


end
