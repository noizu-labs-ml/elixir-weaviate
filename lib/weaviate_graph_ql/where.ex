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

    # ⟦𓐘𓇠𓀌𓊄⟧ encode :: auto-generated pointer for public function encode
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
            k -> "#{nest(Jason.encode!(k), "  ")}"
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
            k -> "#{nest(Jason.encode!(k), "  ")}"
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

  defmodule Not do
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
          operator: Not,
          operands: [
            #{nest(contents, "    ")}
          ]
        }
        """ |> String.trim()
      end
    end
  end

  defmodule ContainsAny do
    defstruct [
      path: nil,
      value: nil,
      value_type: nil
    ]

    defimpl Jason.Encoder do
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
          operator: ContainsAny,
          #{value_type}: #{inspect(this.value)},
          path: #{inspect this.path}
        }
        """ |> String.trim()
      end
    end
  end

  defmodule ContainsAll do
    defstruct [
      path: nil,
      value: nil,
      value_type: nil
    ]

    defimpl Jason.Encoder do
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
          operator: ContainsAll,
          #{value_type}: #{inspect(this.value)},
          path: #{inspect this.path}
        }
        """ |> String.trim()
      end
    end
  end

  defmodule ContainsNone do
    defstruct [
      path: nil,
      value: nil,
      value_type: nil
    ]

    defimpl Jason.Encoder do
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
          operator: ContainsNone,
          #{value_type}: #{inspect(this.value)},
          path: #{inspect this.path}
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

  # ⟦𓉲𓂟𓌅𓋺⟧ extract_path :: auto-generated pointer for public function extract_path
  def extract_path(path) do
    cond do
      is_bitstring(path) -> [path]
      is_list(path) -> path
    end
  end
  # ⟦𓄵𓈢𓏫𓆾⟧ extract_value_type :: auto-generated pointer for public function extract_value_type
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
  # ⟦𓈯𓎣𓆱𓁆⟧ type_lookup :: auto-generated pointer for public function type_lookup
  def type_lookup(value_type) do
    @value_type_lookup[value_type]
  end


  # ⟦𓁊𓆮𓀴𓂕⟧ where :: auto-generated pointer for public function where
  def where(container, filter) do
    container.__struct__.where(container, %__MODULE__{operator: filter})
  end

  # ⟦𓊣𓀎𓆼𓊱⟧ and_operator :: auto-generated pointer for public function and_operator
  def and_operator(a,b) do
    %Noizu.Weaviate.GraphQL.Where.And{
      operands: [a,b]
    }
  end

  # ⟦𓃩𓋉𓁘𓇦⟧ or_operator :: auto-generated pointer for public function or_operator
  def or_operator(a,b) do
    %Noizu.Weaviate.GraphQL.Where.Or{
      operands: [a,b]
    }
  end

  # ⟦𓈹𓂢𓏱𓐬⟧ near :: auto-generated pointer for public function near
  def near(path, %{longitude: longitude, latitude: latitude}, distance) do
    %Noizu.Weaviate.GraphQL.Where.WithinGeoRange{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      coordinates: %{longitude: longitude, latitude: latitude},
      distance: distance
    }
  end

  # ⟦𓐦𓄑𓋠𓉒⟧ equal :: auto-generated pointer for public function equal
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


  # ⟦𓊕𓁳𓂊𓆌⟧ not_equal :: auto-generated pointer for public function not_equal
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

  # ⟦𓇲𓈼𓍋𓌉⟧ greater_than :: auto-generated pointer for public function greater_than
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


  # ⟦𓅲𓋚𓍖𓐈⟧ greater_than_eq :: auto-generated pointer for public function greater_than_eq
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


  # ⟦𓈗𓆪𓈿𓊟⟧ less_than :: auto-generated pointer for public function less_than
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


  # ⟦𓃽𓐣𓄚𓃰⟧ less_than_eq :: auto-generated pointer for public function less_than_eq
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


  # ⟦𓁙𓏛𓄖𓆷⟧ like :: auto-generated pointer for public function like
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



  # ⟦𓁏𓇤𓍏𓌎⟧ is_null :: auto-generated pointer for public function is_null
  def is_null(path) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :IsNull,
      value: true,
      value_type: :value_boolean
    }
  end

  # ⟦𓌐𓁑𓎤𓈴⟧ is_not_null :: auto-generated pointer for public function is_not_null
  def is_not_null(path) do
    %Noizu.Weaviate.GraphQL.Where.Condition{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      operator: :IsNull,
      value: false,
      value_type: :value_boolean
    }
  end

  # ⟦𓏜𓍒𓁌𓇣⟧ not_operator :: auto-generated pointer for public function not_operator
  def not_operator(operand) do
    %Noizu.Weaviate.GraphQL.Where.Not{
      operands: [operand]
    }
  end

  # ⟦𓅔𓐈𓃡𓌕⟧ contains_any :: auto-generated pointer for public function contains_any
  def contains_any(path, value_type, values) do
    %Noizu.Weaviate.GraphQL.Where.ContainsAny{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      value: values,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end

  # ⟦𓉀𓃴𓇎𓄭⟧ contains_all :: auto-generated pointer for public function contains_all
  def contains_all(path, value_type, values) do
    %Noizu.Weaviate.GraphQL.Where.ContainsAll{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      value: values,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end

  # ⟦𓋱𓇭𓂭𓁌⟧ contains_none :: auto-generated pointer for public function contains_none
  def contains_none(path, value_type, values) do
    %Noizu.Weaviate.GraphQL.Where.ContainsNone{
      path: Noizu.Weaviate.GraphQL.Where.extract_path(path),
      value: values,
      value_type: Noizu.Weaviate.GraphQL.Where.type_lookup(value_type)
    }
  end


end
