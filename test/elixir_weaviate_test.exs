defmodule ElixirWeaviateTest do
  use ExUnit.Case
  doctest ElixirWeaviate

  test "greets the world" do
    assert ElixirWeaviate.hello() == :world
  end
end
