defmodule Noizu.Weaviate.Struct.VectorIndexConfig do
  defstruct [
    :distance,
    :ef,
    :ef_construction,
    :max_connections,
    :dynamic_ef_min,
    :dynamic_ef_max,
    :dynamic_ef_factor,
    :vector_cache_max_objects,
    :flat_search_cutoff,
    :cleanup_interval_seconds,
    :pq,
    :skip
  ]

  def from_json(json) when is_list(json) do
    Enum.map(json, & from_json(&1))
  end
  def from_json(nil), do: nil
  def from_json(%{} = json) do
    %__MODULE__{
      distance: json[:distance],
      ef: json[:ef],
      ef_construction: json[:efConstruction],
      max_connections: json[:maxConnections],
      dynamic_ef_min: json[:dynamicEfMin],
      dynamic_ef_max: json[:dynamicEfMax],
      dynamic_ef_factor: json[:dynamicEfFactor],
      vector_cache_max_objects: json[:vectorCacheMaxObjects],
      flat_search_cutoff: json[:flatSearchCutoff],
      cleanup_interval_seconds: json[:cleanupIntervalSeconds],
      pq: json[:pq],
      skip: json[:skip]
    }
  end

  defimpl Jason.Encoder do
    def encode(this, opts) do
      %{
        distance: this.distance,
        ef: this.ef,
        efConstruction: this.ef_construction,
        maxConnections: this.max_connections,
        dynamicEfMin: this.dynamic_ef_min,
        dynamicEfMax: this.dynamic_ef_max,
        dynamicEfFactor: this.dynamic_ef_factor,
        vectorCacheMaxObjects: this.vector_cache_max_objects,
        flatSearchCutoff: this.flat_search_cutoff,
        cleanupIntervalSeconds: this.cleanup_interval_seconds,
        pq: this.pq,
        skip: this.skip
      }
      |> Enum.reject(fn {k,v} -> is_nil(v) end)
      |> Map.new()
      |> Jason.Encode.map(opts)
    end
  end
end
