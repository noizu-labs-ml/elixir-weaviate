defmodule Noizu.Weaviate.Test.LiveArticle do
  use Noizu.Weaviate.Class
  weaviate_class("LiveTestArticle") do
    description "Live test article for integration testing"
    vectorizer "none"
    property :title, :text
    property :body, :text
    property :category, :text
    property :word_count, :int
  end
end
