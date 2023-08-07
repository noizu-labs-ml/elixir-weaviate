defmodule Noizu.Weaviate.Test.Article do
  use Noizu.Weaviate.Class
  weaviate_class("Article") do
    description "Article Schema Class"
    property :title, :string
    property :body, :text
  end
end
