defmodule Noizu.Weaviate.GraphQL.Additional do
  defmodule Classification do
    defstruct [
      properties: []
    ]

    def classification(properties) do
      properties = (is_list(properties) && properties || [properties])
                   |> Enum.filter(fn(p) -> p in [:id, :classified_fields, :based_on, :completed, :scope] end)
      unless properties == [] do
        %__MODULE__{
          properties: properties
        }
      end
    end


    defimpl Jason.Encoder do

      @lookup %{
        id: "id",
        scope: "scope",
        completed: "completed",
        based_on: "basedOn",
        classified_fields: "classifiedFields"
      }

      def encode(this, opts) do
        properties = Enum.map(this.properties, &(@lookup[&1]))
        |> Enum.join("\n  ")
        encoded = """
        classification {
          #{properties}
        }
        """ |> String.trim()
      end
    end

  end

  defmodule FeatureProjection do
    defstruct [
      dimensions: 2,
      algorithm: nil,
      perplexity: nil,
      learning_rate: nil,
      iterations: nil,
      properties: [:vector]
    ]
    def feature_projection(options) do
      %__MODULE__{
        dimensions: options[:dimensions] || 2,
        algorithm: options[:algorithm],
        perplexity: options[:perplexity],
        learning_rate: options[:learning_rate],
        iterations: options[:iterations]
      }
    end


    defimpl Jason.Encoder do

      @lookup %{
        vector: "vector",
      }

      def encode(this, opts) do
        properties = Enum.map(this.properties, &(@lookup[&1]))
                     |> Enum.join("\n  ")
        options =
          []
          |> then(& this.dimensions && [{:dimensions, this.dimensions}|&1] || &1 )
          |> then(& this.algorithm && [{:algorithm, this.algorithm}|&1] || &1 )
          |> then(& this.perplexity && [{:perplexity, this.perplexity}|&1] || &1 )
          |> then(& this.learning_rate && [{:learningRate, this.learning_rate}|&1] || &1 )
          |> then(& this.iterations && [{:iterations, this.iterations}|&1] || &1 )
          |> Enum.map(fn({k,v}) -> "#{k}: #{inspect v}" end)
          |> Enum.join(", ")

        encoded = """
                  featureProjection(#{options}) {
                    #{properties}
                  }
                  """ |> String.trim()
      end
    end

  end

  defstruct [
    properties: [],
  ]

  def additional(properties) do
    properties = cond do
      is_list(properties) -> properties
      :else -> [properties]
    end
    %__MODULE__{properties: properties}
  end

  defimpl Jason.Encoder do
    @lookup %{
      id: "id",
      vector: "vector",
      generate: "generate",
      rerank: "rerank",
      creation_time: "creationTimeUnix",
      last_update_time: "lastUpdateTimeUnix",
      distance: "distance",
    }

    def encode(this, opts) do
      contents = Enum.map(this.properties,
        fn
          (property) when property in [:id, :vector, :generate, :rerank, :creation_time, :last_update_time, :distance] -> @lookup[property]
          (property = %FeatureProjection{}) -> Jason.encode!(property)
          (property = %Classification{}) -> Jason.encode!(property)
          (_) -> nil
        end)
      |> Enum.reject(&is_nil/1)
      |> Enum.join("\n  ")

      """
      _additional {
        #{contents}
      }
      """ |> String.trim()
    end
  end
end
