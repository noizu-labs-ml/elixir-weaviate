defmodule Noizu.Weaviate.Test.Foo do
  use Noizu.Weaviate.Class
  weaviate_class("Foo") do
    description "Foo Schema Class"
    property :title, :string
    property :body, :text
  end
end
