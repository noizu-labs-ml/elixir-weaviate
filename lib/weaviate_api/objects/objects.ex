defmodule Noizu.Weaviate.Api.Objects do
  @moduledoc """
  Functions for interacting with data objects in Weaviate.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate


  def query(query, options \\ nil) do
    url = api_base() <> "v1/graphql"
#    decoder = options[:decoder] || (case query do
#      %{class: class} when is_atom(class) -> class
#      _ -> :json
#    end)
    api_call(:post, url, query, :json, options)
  end

  def list(class, options \\ nil) do
    class_name = case class do
      %{meta: %{class: class}} -> class
      v when is_bitstring(class) -> class
    end
    decoder = options[:decoder] || Noizu.Weaviate.Class.Protocol.decoder(class, options)
    query_params =
      []
      |> then(& [{"class", class_name}| &1])
      |> then(& options[:limit] && [{"limit", options[:limit]}| &1] || &1)
      |> then(& options[:offset] && [{"offset", options[:offset]}| &1] || &1)
      |> then(& options[:after] && [{"after", options[:after]}| &1] || &1)
      |> then(& options[:include] && [{"include", options[:include]}| &1] || &1)
      |> then(& options[:sort] && [{"sort", options[:sort]}| &1] || &1)
      |> then(& options[:order] && [{"order", options[:order]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    url = api_base() <> "v1/objects#{query_params && "?" <> query_params || ""}"
    api_call(:get, url, nil, decoder, options)
  end

  def exists?(object, options \\ nil) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> then(& options[:tenant] && [{"tenant", options[:tenant]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    decoder = options[:decoder] || Noizu.Weaviate.Class.Protocol.decoder(object, options)
    class = Noizu.Weaviate.Class.Protocol.class(object, options)
    id = Noizu.Weaviate.Class.Protocol.id(object, options)

    url = api_base() <> "v1/objects/#{class}/#{id}#{query_params && "?" <> query_params || ""}"
    api_call(:head, url, nil, decoder, options)
  end

  def validate?(object, options \\ nil) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    url = api_base() <> "v1/objects/validate#{query_params && "?" <> query_params || ""}"

    decoder = options[:decoder] || Noizu.Weaviate.Class.Protocol.decoder(object, options)

    api_call(:post, url, object, decoder, options)
  end

  def create(object, options \\ nil) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    url = api_base() <> "v1/objects#{query_params && "?" <> query_params || ""}"
    decoder = options[:decoder] || Noizu.Weaviate.Class.Protocol.decoder(object, options)
    api_call(:post, url, object, decoder, options)
  end

  def get(object, options \\ nil) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> then(& options[:tenant] && [{"tenant", options[:tenant]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    decoder = options[:decoder] || Noizu.Weaviate.Class.Protocol.decoder(object, options)
    class = Noizu.Weaviate.Class.Protocol.class(object, options)
    id = Noizu.Weaviate.Class.Protocol.id(object, options)
    url = api_base() <> "v1/objects/#{class}/#{id}#{query_params && "?" <> query_params || ""}"
    api_call(:get, url, nil, decoder, options)
  end

  def get(class, object, options) when is_bitstring(class) and is_bitstring(object) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> then(& options[:tenant] && [{"tenant", options[:tenant]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    url = api_base() <> "v1/objects/#{class}/#{object}#{query_params && "?" <> query_params || ""}"
    decoder = options[:decoder] || :json
    api_call(:get, url, nil, decoder, options)
  end

  def update(object, options \\ nil) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    decoder = options[:decoder] || Noizu.Weaviate.Class.Protocol.decoder(object, options)
    class = Noizu.Weaviate.Class.Protocol.class(object, options)
    id = Noizu.Weaviate.Class.Protocol.id(object, options)
    url = api_base() <> "v1/objects/#{class}/#{id}#{query_params && "?" <> query_params || ""}"
    api_call(:put, url, object, decoder, options)
  end

  def patch(object, options \\ nil) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")
    decoder = options[:decoder] || Noizu.Weaviate.Class.Protocol.decoder(object, options)
    class = Noizu.Weaviate.Class.Protocol.class(object, options)
    id = Noizu.Weaviate.Class.Protocol.id(object, options)
    url = api_base() <> "v1/objects/#{class}/#{id}#{query_params && "?" <> query_params || ""}"
    api_call(:patch, url, object, decoder, options)
  end

  def delete(object, options \\ nil) do
    query_params =
      []
      |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
      |> then(& options[:tenant] && [{"tenant", options[:tenant]}| &1] || &1)
      |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
      |> Enum.join("&")
    class = Noizu.Weaviate.Class.Protocol.class(object, options)
    id = Noizu.Weaviate.Class.Protocol.id(object, options)
    url = api_base() <> "v1/objects/#{class}/#{id}#{query_params && "?" <> query_params || ""}"
    api_call(:delete, url, nil, :json, options)
  end


  defmodule CrossReference do

    def add(object, reference, beacon, options \\ nil) do
      query_params =
        []
        |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
        |> then(& options[:tenant] && [{"tenant", options[:tenant]}| &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
        |> Enum.join("&")

      class = Noizu.Weaviate.Class.Protocol.class(object, options)
      id = Noizu.Weaviate.Class.Protocol.id(object, options)

      url = api_base() <> "v1/objects/#{class}/#{id}/references/#{reference}#{query_params && "?" <> query_params || ""}"
      api_call(:post, url, %{beacon: beacon}, :json, options)
    end

    def update(object, reference, beacons, options \\ nil) do
      query_params =
        []
        |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
        |> then(& options[:tenant] && [{"tenant", options[:tenant]}| &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
        |> Enum.join("&")
      class = Noizu.Weaviate.Class.Protocol.class(object, options)
      id = Noizu.Weaviate.Class.Protocol.id(object, options)
      url = api_base() <> "v1/objects/#{class}/#{id}/references/#{reference}#{query_params && "?" <> query_params || ""}"
      api_call(:put, url, beacons, :json, options)
    end

    def delete(object, reference, beacon, options \\ nil) do
      query_params =
        []
        |> then(& options[:consistency_level] && [{"consistency_level", options[:consistency_level]}| &1] || &1)
        |> then(& options[:tenant] && [{"tenant", options[:tenant]}| &1] || &1)
        |> Enum.map(fn {k,v} -> "#{k}=#{v}" end)
        |> Enum.join("&")
      class = Noizu.Weaviate.Class.Protocol.class(object, options)
      id = Noizu.Weaviate.Class.Protocol.id(object, options)
      url = api_base() <> "v1/objects/#{class}/#{id}/references/#{reference}#{query_params && "?" <> query_params || ""}"
      api_call(:delete, url, %{beacon: beacon}, :json, options)
    end
  end
end
