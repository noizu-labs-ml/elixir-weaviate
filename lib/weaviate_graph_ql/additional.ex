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

  defmodule Answer do
    defstruct []

    defimpl Jason.Encoder do
      def encode(_this, _opts) do
        """
        answer {
          hasAnswer
          result
          certainty
          property
          startPosition
          endPosition
        }
        """ |> String.trim()
      end
    end
  end

  defmodule Generate do
    defstruct [
      single_result_prompt: nil,
      grouped_result_task: nil,
      grouped_result_properties: nil
    ]

    defimpl Jason.Encoder do
      def encode(this, _opts) do
        options =
          []
          |> then(& this.single_result_prompt && [{:singleResult, %{prompt: this.single_result_prompt}}|&1] || &1 )
          |> then(& this.grouped_result_task && [{:groupedResult, %{task: this.grouped_result_task, properties: this.grouped_result_properties}}|&1] || &1 )

        options_str = Enum.map(options, fn
          {:singleResult, %{prompt: prompt}} -> "singleResult: { prompt: #{inspect prompt} }"
          {:groupedResult, %{task: task, properties: nil}} -> "groupedResult: { task: #{inspect task} }"
          {:groupedResult, %{task: task, properties: props}} ->
            props_str = Enum.map(props, &inspect/1) |> Enum.join(", ")
            "groupedResult: { task: #{inspect task}, properties: [#{props_str}] }"
        end)
        |> Enum.join("\n  ")

        """
        generate(
          #{options_str}
        ) {
          singleResult
          groupedResult
          error
        }
        """ |> String.trim()
      end
    end
  end

  defmodule Rerank do
    defstruct [
      property: nil,
      query: nil
    ]

    defimpl Jason.Encoder do
      def encode(this, _opts) do
        options =
          []
          |> then(& this.property && [{:property, this.property}|&1] || &1 )
          |> then(& this.query && [{:query, this.query}|&1] || &1 )
          |> Enum.map(fn({k,v}) -> "#{k}: #{inspect v}" end)
          |> Enum.join(", ")

        """
        rerank(#{options}) {
          score
        }
        """ |> String.trim()
      end
    end
  end

  defmodule Summary do
    defstruct [
      properties: []
    ]

    defimpl Jason.Encoder do
      def encode(this, _opts) do
        props_str = Enum.map(this.properties, &inspect/1) |> Enum.join(", ")

        """
        summary(properties: [#{props_str}]) {
          property
          result
        }
        """ |> String.trim()
      end
    end
  end

  defmodule Tokens do
    defstruct [
      properties: [],
      certainty: nil,
      limit: nil
    ]

    defimpl Jason.Encoder do
      def encode(this, _opts) do
        props_str = Enum.map(this.properties, &inspect/1) |> Enum.join(", ")
        options =
          [{:properties, "[#{props_str}]"}]
          |> then(& this.certainty && [{:certainty, this.certainty}|&1] || &1 )
          |> then(& this.limit && [{:limit, this.limit}|&1] || &1 )
          |> Enum.reverse()
          |> Enum.map(fn
            {:properties, v} -> "properties: #{v}"
            {k, v} -> "#{k}: #{v}"
          end)
          |> Enum.join(", ")

        """
        tokens(#{options}) {
          entity
          word
          property
          certainty
          startPosition
          endPosition
        }
        """ |> String.trim()
      end
    end
  end

  defmodule Group do
    defstruct [
      hit_properties: [],
      hit_additional: []
    ]

    defimpl Jason.Encoder do
      def encode(this, _opts) do
        hit_props = Enum.join(this.hit_properties, "\n        ")
        hit_additional = case this.hit_additional do
          [] -> ""
          additional ->
            adds = Enum.join(additional, "\n          ")
            "\n        _additional { #{adds} }"
        end

        hits_block = case {this.hit_properties, this.hit_additional} do
          {[], []} -> ""
          _ ->
            """
                hits {
                  #{hit_props}#{hit_additional}
                }
            """ |> String.trim_trailing()
        end

        """
        group {
          id
          groupedBy { value path }
          count
          maxDistance
          minDistance
          #{hits_block}
        }
        """ |> String.trim()
      end
    end
  end

  defmodule Vectors do
    defstruct [
      names: []
    ]

    defimpl Jason.Encoder do
      def encode(this, _opts) do
        names_str = Enum.join(this.names, "\n  ")

        """
        vectors {
          #{names_str}
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
      certainty: "certainty",
      score: "score",
      explain_score: "explainScore",
      is_consistent: "isConsistent",
    }

    def encode(this, opts) do
      contents = Enum.map(this.properties,
        fn
          (property) when property in [:id, :vector, :generate, :rerank, :creation_time, :last_update_time, :distance, :certainty, :score, :explain_score, :is_consistent] -> @lookup[property]
          (property = %FeatureProjection{}) -> Jason.encode!(property)
          (property = %Classification{}) -> Jason.encode!(property)
          (property = %Answer{}) -> Jason.encode!(property)
          (property = %Generate{}) -> Jason.encode!(property)
          (property = %Rerank{}) -> Jason.encode!(property)
          (property = %Summary{}) -> Jason.encode!(property)
          (property = %Tokens{}) -> Jason.encode!(property)
          (property = %Group{}) -> Jason.encode!(property)
          (property = %Vectors{}) -> Jason.encode!(property)
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
