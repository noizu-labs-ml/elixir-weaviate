# lib/ — Application Source

## weaviate_api/

REST API wrappers. Each subdirectory maps 1:1 to a Weaviate REST resource.

```
weaviate_api/
├── authz/authz.ex                  # Authorization endpoints
├── backups/backups.ex              # Backup create/restore/status
├── batch/batch.ex                  # Batch object operations
├── classification/classification.ex # Classification scheduling
├── cluster/cluster.ex              # Cluster statistics
├── meta/meta.ex                    # Server meta information
├── nodes/nodes.ex                  # Node status
├── objects/objects.ex              # CRUD + GraphQL query dispatch
├── schema/schema.ex                # Collection schema management
└── well_known/auth.ex              # OpenID/.well-known endpoints
```

## weaviate_classes/

Macro system for defining Elixir modules that map to Weaviate collections.

```
weaviate_classes/
├── class.ex                        # `weaviate_class` macro definition
└── protocol.ex                     # Class.Protocol for polymorphic dispatch
```

## weaviate_graph_ql/

Builder-pattern GraphQL query construction.

```
weaviate_graph_ql/
├── search_operator/                # Search operator structs
│   ├── ask.ex                      #   QnA ask operator
│   ├── bm25.ex                     #   BM25 keyword search
│   ├── group.ex                    #   Result grouping
│   ├── hybrid.ex                   #   Hybrid (vector + keyword)
│   ├── near_audio.ex               #   Audio similarity
│   ├── near_depth.ex               #   Depth map similarity
│   ├── near_image.ex               #   Image similarity
│   ├── near_imu.ex                 #   IMU data similarity
│   ├── near_object.ex              #   Object-to-object similarity
│   ├── near_text.ex                #   Text semantic search
│   ├── near_thermal.ex             #   Thermal image similarity
│   ├── near_vector.ex              #   Raw vector search
│   └── near_video.ex               #   Video similarity
├── additional.ex                   # _additional fields selection
├── aggregate.ex                    # Aggregate query builder
├── explore.ex                      # Explore query builder
├── get.ex                          # Get query builder
├── graph_ql.ex                     # Entry point module
├── group_by.ex                     # GroupBy clause builder
└── where.ex                        # Where filter builder
```

## weaviate_structs/

Data type structs representing Weaviate schema and object concepts.

```
weaviate_structs/
├── inverted_index_config/          # Nested config structs
│   ├── bm25.ex                     #   BM25 tuning parameters
│   └── stopwords.ex                #   Stopword configuration
├── backup_params.ex                # Backup operation parameters
├── batch_params.ex                 # Batch operation parameters
├── class.ex                        # Collection schema definition
├── classification_params.ex        # Classification parameters
├── data_object.ex                  # Weaviate data object
├── inverted_index_confix.ex        # Inverted index configuration
├── meta.ex                         # Server metadata
├── multi_tenancy_config.ex         # Multi-tenancy settings
├── node.ex                         # Cluster node info
├── openid_configuration.ex         # OpenID provider config
├── property.ex                     # Collection property definition
├── replication_config.ex           # Replication settings
├── schema.ex                       # Full schema response
├── sharding_confix.ex              # Sharding configuration
├── tenent.ex                       # Tenant definition
└── vector_index_config.ex          # Vector index (HNSW) settings
```

## Root Files

```
├── application.ex                  # OTP Application — starts Finch pool
└── noizu_weaviate.ex               # Root module — api_call/5, config helpers
```
