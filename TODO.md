## Code Quality

1. [ ] Improve error handling: Add proper error handling and error messages throughout the codebase.
2. [ ] Add type specifications: Add @type and @spec to all functions and structs.
3. [ ] Refactor struct definitions: Follow Elixir conventions, make code more maintainable.
4. [ ] Remove unused code: Remove unused functions, modules, and variables.
5. [ ] Implement logging: Add logging to API calls for debugging.
6. [ ] Optimize API call handling: Proper HTTP status code checks and error handling.
7. [ ] Implement proper pagination: Pagination support in object listing API calls.
8. [ ] Use keyword lists consistently: For function parameter options.
9. [ ] Improve documentation: Inline and module-level documentation.
10. [ ] Refactor API call implementation: Reduce duplication, improve readability.

## New Weaviate Features (v1.25+)

See [docs/rest-api.md](docs/rest-api.md), [docs/graphql.md](docs/graphql.md), and [docs/modules.md](docs/modules.md) for full details.

### GraphQL

11. [ ] Aggregate queries: Implement `Noizu.Weaviate.GraphQL.Aggregate` - count, sum, mean, median, mode, min, max, topOccurrences, groupedBy.
12. [ ] Explore queries: Implement `Noizu.Weaviate.GraphQL.Explore` - cross-collection vector search.
13. [ ] Multi-tenancy in queries: Add `tenant` parameter to Get and Aggregate queries.
14. [ ] Named vectors in queries: Add `targetVectors` parameter to search operators.
15. [ ] Hybrid search improvements: Support `fusionType` (rankedFusion, relativeScoreFusion), `alpha`, `properties` targeting.
16. [ ] New search operators: nearAudio, nearVideo, nearDepth, nearThermal, nearIMU.
17. [ ] ContainsAny/ContainsAll filters: Array-based filter operators.
18. [ ] Additional properties: Add score, explainScore, certainty, tokens, summary, group (groupBy hits), vectors (named).
19. [ ] Generative search structure: Build out singleResult/groupedResult prompt params for _additional.generate.
20. [ ] Reranking structure: Build out property/query params and score response for _additional.rerank.

### REST API

21. [ ] Named vectors support: Add `vectorConfig` to Class definition, support `vectors` field in objects.
22. [ ] Nested properties: Support object/object[] property types with nestedProperties.
23. [ ] New property types: uuid, uuid[] types in Class property definitions.
24. [ ] Vector index types: Support flat, dynamic index types alongside hnsw.
25. [ ] Vector quantization: Support PQ, BQ, SQ configuration in vectorIndexConfig.
26. [ ] RBAC endpoints: Implement Noizu.Weaviate.Api.RBAC for role/permission management.
27. [ ] Cluster endpoint: GET /v1/cluster/statistics.
28. [ ] Object references: Add/replace/delete reference endpoints.
29. [ ] Object HEAD: Check object existence endpoint.
30. [ ] Tenant states: Support INACTIVE, OFFLOADED states in tenant operations.
31. [ ] Auto-tenant config: Support autoTenantCreation and autoTenantActivation in MultiTenancyConfig.
32. [ ] Batch consistency level: Support X-Weaviate-Consistency-Level header in batch operations.
33. [ ] Nodes per collection: GET /v1/nodes/{className} endpoint.

### Module Configuration

34. [ ] Generative module configs: Support all generative module configuration options.
35. [ ] Reranker module configs: Support all reranker module configuration options.
36. [ ] Per-property vectorizer config: Support skip/vectorizePropertyName per property.
