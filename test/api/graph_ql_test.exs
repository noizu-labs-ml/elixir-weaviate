defmodule Noizu.Weaviate.Api.GraphQLTest do
  use ExUnit.Case, async: false
  use Mimic
  alias Noizu.Weaviate.GraphQL

  describe "GraphQL get" do
    test "encode - simple" do
      graph = GraphQL.get("Article")
              |> GraphQL.properties(["title", "body"])
      {:ok, sut} = Jason.encode(graph)
      expected = """
      {"query": "{
        Get {
          Article {
             title
             body
          }
        }
      }"}
      """ |> String.trim() |> String.replace("\n", "\\n")
      assert sut == expected
    end

    test "encode - with limit" do
      graph = GraphQL.get("Article")
              |> GraphQL.properties(["title", "body"])
              |> GraphQL.limit(50)
      {:ok, sut} = Jason.encode(graph)
      expected = """
                 {"query": "{
                   Get {
                     Article (
                        limit: 50
                     ) {
                        title
                        body
                     }
                   }
                 }"}
                 """ |> String.trim() |> String.replace("\n", "\\n")
      assert sut == expected
    end

    test "encode - with limit and offset" do
      graph = GraphQL.get("Article")
              |> GraphQL.properties(["title", "body"])
              |> GraphQL.limit(50)
              |> GraphQL.offset(5)
      {:ok, sut} = Jason.encode(graph)
      expected = """
                 {"query": "{
                   Get {
                     Article (
                        offset: 5,
                        limit: 50
                     ) {
                        title
                        body
                     }
                   }
                 }"}
                 """ |> String.trim() |> String.replace("\n", "\\n")
      assert sut == expected
    end


    test "encode - with additional" do
      graph = GraphQL.get("Article")
              |> GraphQL.properties(["title", "body"])
              |> GraphQL.limit(50)
              |> GraphQL.offset(5)
              |> GraphQL.additional(:generate)
      {:ok, sut} = Jason.encode(graph)
      expected = """
                 {"query": "{
                   Get {
                     Article (
                        offset: 5,
                        limit: 50
                     ) {
                        title
                        body
                        _additional {
                          generate
                        }
                     }
                   }
                 }"}
                 """ |> String.trim() |> String.replace("\n", "\\n")
      assert sut == expected
    end


    test "encode - with where" do
      graph = GraphQL.get("Article")
              |> GraphQL.properties(["title", "body"])
              |> GraphQL.limit(50)
              |> GraphQL.offset(5)
              |> GraphQL.where(filter: GraphQL.Where.equal("title", :string, "apple"))
      {:ok, sut} = Jason.encode(graph)
      expected = """
                 {"query": "{
                   Get {
                     Article (
                        where: {
                            operator: Equal,
                            valueString: \\"apple\\",
                            path: [\\"title\\"]
                          },
                        offset: 5,
                        limit: 50
                     ) {
                        title
                        body
                     }
                   }
                 }"}
                 """ |> String.trim() |> String.replace("\n", "\\n")
      assert sut == expected
    end

  end


end
