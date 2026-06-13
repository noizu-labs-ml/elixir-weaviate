defmodule Noizu.Weaviate.Live.FullCycleTest do
  use ExUnit.Case, async: false
  @moduletag :live

  alias Noizu.Weaviate.Api
  alias Noizu.Weaviate.GraphQL

  @test_class "LiveTestArticle"

  setup_all do
    Api.Schema.Class.delete(@test_class)
    Process.sleep(500)
    :ok
  end

  describe "REST API - meta & health" do
    @tag :live
    test "meta - get server info" do
      {:ok, meta} = Api.Meta.get_meta_information()
      assert is_map(meta) || is_struct(meta)
    end

    @tag :live
    test "auth - liveness check" do
      result = Api.Auth.check_liveness()
      assert match?({:ok, _}, result)
    end

    @tag :live
    test "auth - readiness check" do
      result = Api.Auth.check_readiness()
      assert match?({:ok, _}, result)
    end

    @tag :live
    test "nodes - get cluster info" do
      {:ok, result} = Api.Nodes.get_information_about_nodes()
      assert result
    end
  end

  describe "REST API - schema lifecycle" do
    @tag :live
    test "create, get, list, delete class" do
      # Create
      {:ok, created} = Api.Schema.Class.create(Noizu.Weaviate.Test.LiveArticle)
      assert created

      Process.sleep(500)

      # Get
      {:ok, fetched} = Api.Schema.Class.get(@test_class)
      class_name = cond do
        is_struct(fetched) && Map.has_key?(fetched, :name) -> fetched.name
        is_map(fetched) -> fetched[:class] || fetched[:name]
        true -> nil
      end
      assert class_name == @test_class

      # List all
      {:ok, schema} = Api.Schema.get()
      classes = cond do
        is_struct(schema) && Map.has_key?(schema, :classes) -> schema.classes
        is_map(schema) -> schema[:classes]
        true -> []
      end
      assert is_list(classes)

      # Delete
      {:ok, _} = Api.Schema.Class.delete(@test_class)
      Process.sleep(500)
    end
  end

  describe "REST API - object CRUD" do
    setup do
      Api.Schema.Class.delete(@test_class)
      Process.sleep(300)
      {:ok, _} = Api.Schema.Class.create(Noizu.Weaviate.Test.LiveArticle)
      Process.sleep(500)

      on_exit(fn ->
        Api.Schema.Class.delete(@test_class)
      end)
      :ok
    end

    @tag :live
    test "create, get, update, delete object" do
      obj = %Noizu.Weaviate.Test.LiveArticle{
        meta: %Noizu.Weaviate.Class.Meta{class: @test_class},
        title: "Test Article One",
        body: "This is a test article about Elixir programming.",
        category: "technology",
        word_count: 8
      }

      # Create
      {:ok, created} = Api.Objects.create(obj)
      id = cond do
        is_struct(created) && Map.has_key?(created, :id) -> created.id || created.meta.id
        is_map(created) -> created[:id]
        true -> nil
      end
      assert id, "Expected object ID in response: #{inspect(created)}"

      Process.sleep(500)

      # Get
      {:ok, fetched} = Api.Objects.get(@test_class, id, [])
      assert fetched

      # Update
      updated_obj = %Noizu.Weaviate.Test.LiveArticle{
        id: id,
        meta: %Noizu.Weaviate.Class.Meta{id: id, class: @test_class},
        title: "Updated Test Article",
        body: "This article has been updated.",
        category: "technology",
        word_count: 5
      }
      {:ok, _} = Api.Objects.update(updated_obj)
      Process.sleep(500)

      # Verify update
      {:ok, fetched2} = Api.Objects.get(@test_class, id, [])
      props = cond do
        is_struct(fetched2) -> %{title: fetched2.title}
        is_map(fetched2) -> fetched2[:properties] || fetched2
        true -> %{}
      end
      assert props[:title] == "Updated Test Article"

      # Delete
      {:ok, _} = Api.Objects.delete(updated_obj)
      Process.sleep(300)
    end

    @tag :live
    test "batch create and delete objects" do
      objects = for i <- 1..3 do
        %{
          class: @test_class,
          properties: %{
            title: "Batch Article #{i}",
            body: "Batch article number #{i} for testing.",
            category: "batch-test",
            word_count: 5 + i
          },
          vector: Enum.map(1..128, fn _ -> :rand.uniform() end)
        }
      end

      {:ok, result} = Api.Batch.create_objects(objects)
      assert result
      Process.sleep(1500)

      # Verify via GraphQL
      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "category"])
              |> GraphQL.where(
                   Noizu.Weaviate.GraphQL.Where.equal("category", :text, "batch-test")
                 )
              |> GraphQL.limit(10)

      {:ok, gql_result} = Api.Objects.query(query)
      data = get_in(gql_result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) == 3

      # Batch delete
      match = %{
        class: @test_class,
        where: %{
          operator: "Equal",
          path: ["category"],
          valueText: "batch-test"
        }
      }
      {:ok, _} = Api.Batch.delete_objects(match)
      Process.sleep(500)
    end
  end

  describe "GraphQL queries" do
    setup do
      Api.Schema.Class.delete(@test_class)
      Process.sleep(300)
      {:ok, _} = Api.Schema.Class.create(Noizu.Weaviate.Test.LiveArticle)
      Process.sleep(500)

      base_vec = List.duplicate(0.0, 128)
      objects = [
        %{
          class: @test_class,
          properties: %{title: "Elixir Concurrency", body: "Elixir uses lightweight processes for concurrency.", category: "elixir", word_count: 7},
          vector: List.replace_at(base_vec, 0, 1.0) |> List.replace_at(1, 0.5)
        },
        %{
          class: @test_class,
          properties: %{title: "Phoenix Framework", body: "Phoenix is a web framework built on Elixir.", category: "elixir", word_count: 8},
          vector: List.replace_at(base_vec, 0, 0.9) |> List.replace_at(1, 0.6)
        },
        %{
          class: @test_class,
          properties: %{title: "Database Design", body: "Proper database design is crucial for performance.", category: "databases", word_count: 7},
          vector: List.replace_at(base_vec, 2, 1.0) |> List.replace_at(3, 0.5)
        },
        %{
          class: @test_class,
          properties: %{title: "Network Security", body: "Network security protects against unauthorized access.", category: "security", word_count: 6},
          vector: List.replace_at(base_vec, 4, 1.0) |> List.replace_at(5, 0.5)
        },
        %{
          class: @test_class,
          properties: %{title: "Erlang OTP", body: "OTP provides patterns for building fault-tolerant systems.", category: "elixir", word_count: 8},
          vector: List.replace_at(base_vec, 0, 0.8) |> List.replace_at(1, 0.7)
        }
      ]

      {:ok, _} = Api.Batch.create_objects(objects)
      Process.sleep(2000)

      on_exit(fn ->
        Api.Schema.Class.delete(@test_class)
      end)

      :ok
    end

    @tag :live
    test "get - basic property query" do
      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "body", "category"])
              |> GraphQL.limit(10)

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) == 5
    end

    @tag :live
    test "get - with limit and offset" do
      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title"])
              |> GraphQL.limit(2)
              |> GraphQL.offset(1)

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) <= 2
    end

    @tag :live
    test "get - with _additional id" do
      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title"])
              |> GraphQL.limit(3)
              |> GraphQL.additional([:id, :creation_time, :last_update_time])

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      first = List.first(data)
      assert first[:_additional][:id]
    end

    @tag :live
    test "get - nearVector search" do
      search_vec = List.duplicate(0.0, 128)
                   |> List.replace_at(0, 1.0)
                   |> List.replace_at(1, 0.5)

      operator = %Noizu.Weaviate.GraphQL.SearchOperator.NearVector{
        vector: search_vec,
        distance: 1.5
      }

      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "category"])
              |> GraphQL.search_operator(operator)
              |> GraphQL.limit(3)
              |> GraphQL.additional([:id, :distance])

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) > 0
      # Closest should be Elixir-related (vectors near [1.0, 0.5, 0, ...])
      first = List.first(data)
      assert first[:category] == "elixir"
    end

    @tag :live
    test "get - where Equal filter" do
      filter = Noizu.Weaviate.GraphQL.Where.equal("category", :text, "elixir")

      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "category"])
              |> GraphQL.where(filter)
              |> GraphQL.limit(10)

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) == 3
      Enum.each(data, fn item ->
        assert item[:category] == "elixir"
      end)
    end

    @tag :live
    test "get - where GreaterThan filter" do
      filter = Noizu.Weaviate.GraphQL.Where.greater_than("word_count", :int, 7)

      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "word_count"])
              |> GraphQL.where(filter)
              |> GraphQL.limit(10)

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) == 2
      Enum.each(data, fn item ->
        assert item[:word_count] > 7
      end)
    end

    @tag :live
    test "get - where And compound filter" do
      filter = Noizu.Weaviate.GraphQL.Where.and_operator(
        Noizu.Weaviate.GraphQL.Where.equal("category", :text, "elixir"),
        Noizu.Weaviate.GraphQL.Where.greater_than("word_count", :int, 7)
      )

      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "category", "word_count"])
              |> GraphQL.where(filter)
              |> GraphQL.limit(10)

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) == 2
      Enum.each(data, fn item ->
        assert item[:category] == "elixir"
        assert item[:word_count] > 7
      end)
    end

    @tag :live
    test "get - where Or compound filter" do
      filter = Noizu.Weaviate.GraphQL.Where.or_operator(
        Noizu.Weaviate.GraphQL.Where.equal("category", :text, "security"),
        Noizu.Weaviate.GraphQL.Where.equal("category", :text, "databases")
      )

      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "category"])
              |> GraphQL.where(filter)
              |> GraphQL.limit(10)

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      assert length(data) == 2
    end

    @tag :live
    test "get - sort ascending" do
      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "word_count"])
              |> GraphQL.sort(%{path: ["word_count"], order: :asc})
              |> GraphQL.limit(5)

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
      counts = Enum.map(data, & &1[:word_count])
      assert counts == Enum.sort(counts)
    end

    @tag :live
    test "get - autocut with vector search" do
      search_vec = List.duplicate(0.0, 128)
                   |> List.replace_at(0, 1.0)
                   |> List.replace_at(1, 0.5)

      operator = %Noizu.Weaviate.GraphQL.SearchOperator.NearVector{
        vector: search_vec
      }

      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title"])
              |> GraphQL.search_operator(operator)
              |> GraphQL.autocut(1)
              |> GraphQL.additional([:id, :distance])

      {:ok, result} = Api.Objects.query(query)
      data = get_in(result, [:data, :Get, String.to_existing_atom(@test_class)])
      assert is_list(data)
    end

    @tag :live
    test "get - groupBy" do
      search_vec = List.duplicate(0.1, 128)

      operator = %Noizu.Weaviate.GraphQL.SearchOperator.NearVector{
        vector: search_vec,
        distance: 2.0
      }

      query = GraphQL.get(@test_class)
              |> GraphQL.properties(["title", "category"])
              |> GraphQL.search_operator(operator)
              |> GraphQL.group_by("category", 3, 2)
              |> GraphQL.additional([:id])

      {:ok, result} = Api.Objects.query(query)
      assert result
    end
  end
end
