defmodule Noizu.Weaviate.Api.SchemaTest do
  use ExUnit.Case, async: false
  use Mimic
  @suffix :os.system_time(:second)

  describe "Schema" do
    test "Get" do
      Mimic.stub(Finch, :request, fn(request, handler, options) ->
        {:ok, %Finch.Response{status: 200, body:
          """
          {"classes":[{"class":"Article","description":"A written text, for example a news article or blog post","invertedIndexConfig":{"bm25":{"b":0.75,"k1":1.2},"cleanupIntervalSeconds":60,"stopwords":{"additions":null,"preset":"en","removals":null}},"moduleConfig":{"text2vec-transformers":{"poolingStrategy":"masked_mean","vectorizeClassName":true}},"multiTenancyConfig":{"enabled":false},"properties":[{"dataType":["text"],"description":"Title of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"title","tokenization":"whitespace"},{"dataType":["text"],"description":"The content of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"content","tokenization":"word"}],"replicationConfig":{"factor":1},"shardingConfig":{"virtualPerPhysical":128,"desiredCount":1,"actualCount":1,"desiredVirtualCount":128,"actualVirtualCount":128,"key":"_id","strategy":"hash","function":"murmur3"},"vectorIndexConfig":{"skip":false,"cleanupIntervalSeconds":300,"maxConnections":64,"efConstruction":128,"ef":-1,"dynamicEfMin":100,"dynamicEfMax":500,"dynamicEfFactor":8,"vectorCacheMaxObjects":1000000000000,"flatSearchCutoff":40000,"distance":"cosine","pq":{"enabled":false,"bitCompression":false,"segments":0,"centroids":256,"trainingLimit":100000,"encoder":{"type":"kmeans","distribution":"log-normal"}}},"vectorIndexType":"hnsw","vectorizer":"text2vec-transformers"}]}
          """
          |> String.trim()
        }}
      end)
      {:ok, sut = %Noizu.Weaviate.Struct.Schema{}} = Noizu.Weaviate.Api.Schema.get()
      [class] = sut.classes
      assert class.name == "Article"
    end
  end

  describe "Schema Classes" do
    test "Create" do
      Mimic.stub(Finch, :request, fn(request, handler, options) ->
        {:ok, %Finch.Response{status: 200, body:
          """
          {"class":"Article","description":"A written text, for example a news article or blog post","invertedIndexConfig":{"bm25":{"b":0.75,"k1":1.2},"cleanupIntervalSeconds":60,"stopwords":{"additions":null,"preset":"en","removals":null}},"moduleConfig":{"text2vec-transformers":{"poolingStrategy":"masked_mean","vectorizeClassName":true}},"multiTenancyConfig":{"enabled":false},"properties":[{"dataType":["text"],"description":"Title of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"title","tokenization":"whitespace"},{"dataType":["text"],"description":"The content of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"content","tokenization":"word"}],"replicationConfig":{"factor":1},"shardingConfig":{"virtualPerPhysical":128,"desiredCount":1,"actualCount":1,"desiredVirtualCount":128,"actualVirtualCount":128,"key":"_id","strategy":"hash","function":"murmur3"},"vectorIndexConfig":{"skip":false,"cleanupIntervalSeconds":300,"maxConnections":64,"efConstruction":128,"ef":-1,"dynamicEfMin":100,"dynamicEfMax":500,"dynamicEfFactor":8,"vectorCacheMaxObjects":1000000000000,"flatSearchCutoff":40000,"distance":"cosine","pq":{"enabled":false,"bitCompression":false,"segments":0,"centroids":256,"trainingLimit":100000,"encoder":{"type":"kmeans","distribution":"log-normal"}}},"vectorIndexType":"hnsw","vectorizer":"text2vec-transformers"}
          """
          |> String.trim()
        }}
      end)
      {:ok, sut} = Noizu.Weaviate.Api.Schema.Class.create(Noizu.Weaviate.Test.Article)
      assert sut.meta.class == "Article"
    end

    test "Get" do
      Mimic.stub(Finch, :request, fn(request, handler, options) ->
        {:ok, %Finch.Response{status: 200, body:
          """
          {"class":"Article","description":"A written text, for example a news article or blog post","invertedIndexConfig":{"bm25":{"b":0.75,"k1":1.2},"cleanupIntervalSeconds":60,"stopwords":{"additions":null,"preset":"en","removals":null}},"moduleConfig":{"text2vec-transformers":{"poolingStrategy":"masked_mean","vectorizeClassName":true}},"multiTenancyConfig":{"enabled":false},"properties":[{"dataType":["text"],"description":"Title of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"title","tokenization":"whitespace"},{"dataType":["text"],"description":"The content of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"content","tokenization":"word"}],"replicationConfig":{"factor":1},"shardingConfig":{"virtualPerPhysical":128,"desiredCount":1,"actualCount":1,"desiredVirtualCount":128,"actualVirtualCount":128,"key":"_id","strategy":"hash","function":"murmur3"},"vectorIndexConfig":{"skip":false,"cleanupIntervalSeconds":300,"maxConnections":64,"efConstruction":128,"ef":-1,"dynamicEfMin":100,"dynamicEfMax":500,"dynamicEfFactor":8,"vectorCacheMaxObjects":1000000000000,"flatSearchCutoff":40000,"distance":"cosine","pq":{"enabled":false,"bitCompression":false,"segments":0,"centroids":256,"trainingLimit":100000,"encoder":{"type":"kmeans","distribution":"log-normal"}}},"vectorIndexType":"hnsw","vectorizer":"text2vec-transformers"}
          """
          |> String.trim()
        }}
      end)
      {:ok, sut} = Noizu.Weaviate.Api.Schema.Class.get(Noizu.Weaviate.Test.Article)
      assert sut.name == "Article"
    end

    test "Update" do
      Mimic.stub(Finch, :request, fn(request, handler, options) ->
        {:ok, %Finch.Response{status: 200, body:
          """
          {"class":"Article","description":"A written text, for example a news article or blog post","invertedIndexConfig":{"bm25":{"b":0.75,"k1":1.2},"cleanupIntervalSeconds":60,"stopwords":{"additions":null,"preset":"en","removals":null}},"moduleConfig":{"text2vec-transformers":{"poolingStrategy":"masked_mean","vectorizeClassName":true}},"multiTenancyConfig":{"enabled":false},"properties":[{"dataType":["text"],"description":"Title of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"title","tokenization":"whitespace"},{"dataType":["text"],"description":"The content of the article","indexFilterable":true,"indexSearchable":true,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"content","tokenization":"word"}],"replicationConfig":{"factor":1},"shardingConfig":{"virtualPerPhysical":128,"desiredCount":1,"actualCount":1,"desiredVirtualCount":128,"actualVirtualCount":128,"key":"_id","strategy":"hash","function":"murmur3"},"vectorIndexConfig":{"skip":false,"cleanupIntervalSeconds":300,"maxConnections":64,"efConstruction":128,"ef":-1,"dynamicEfMin":100,"dynamicEfMax":500,"dynamicEfFactor":8,"vectorCacheMaxObjects":1000000000000,"flatSearchCutoff":40000,"distance":"cosine","pq":{"enabled":false,"bitCompression":false,"segments":0,"centroids":256,"trainingLimit":100000,"encoder":{"type":"kmeans","distribution":"log-normal"}}},"vectorIndexType":"hnsw","vectorizer":"text2vec-transformers"}
          """
          |> String.trim()
        }}
      end)
      {:ok, sut} = Noizu.Weaviate.Api.Schema.Class.update(Noizu.Weaviate.Test.Article)
      assert sut.name == "Article"
    end

    test "Delete" do
      Mimic.stub(Finch, :request, fn(request, handler, options) ->
        {:ok, %Finch.Response{status: 200, body: ""}}
      end)
      {:ok, sut} = Noizu.Weaviate.Api.Schema.Class.delete(Noizu.Weaviate.Test.Article)
      assert sut == nil
    end
  end

  describe "Schema Class Properties" do
    test "Add Property" do
      Mimic.stub(Finch, :request, fn(request, handler, options) ->
        {:ok, %Finch.Response{status: 200, body:
          """
          {"dataType":["boolean"],"indexFilterable":true,"indexSearchable":false,"moduleConfig":{"text2vec-transformers":{"skip":false,"vectorizePropertyName":false}},"name":"onHomepage"}
          """
          |> String.trim()
        }}
      end)
      {:ok, sut} = Noizu.Weaviate.Api.Schema.Class.Properties.add(Noizu.Weaviate.Test.Article, Noizu.Weaviate.Test.Article.__property__(:body))
      assert sut.name == "onHomepage"


    end
  end


  describe "Schema Class Shards" do

    # [{"name":"5MW33EwncxT4","status":"READY"}]
    # {"status":"READONLY"}
  end

  describe "Schema Class Tenants" do

  end

end
