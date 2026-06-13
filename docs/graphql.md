# Weaviate GraphQL API Reference

This document covers the full Weaviate GraphQL API surface as of Weaviate v1.28+. It serves as a reference for current and planned `Noizu.Weaviate.GraphQL` module coverage.

## Table of Contents

- [Get Queries](#get-queries)
- [Aggregate Queries](#aggregate-queries)
- [Explore Queries](#explore-queries)
- [Search Operators](#search-operators)
- [Where Filters](#where-filters)
- [Additional Properties](#additional-properties)
- [Sorting](#sorting)
- [Pagination](#pagination)
- [GroupBy](#groupby)
- [Multi-Tenancy](#multi-tenancy)
- [Named Vectors](#named-vectors)
- [Generative Search](#generative-search)
- [Reranking](#reranking)

---

## Get Queries

The `Get` query retrieves data objects from a collection (class).

```graphql
{
  Get {
    <Collection>(
      limit: <Int>
      offset: <Int>
      after: <String>         # cursor-based pagination
      autocut: <Int>          # auto-limit results by score jumps
      sort: [{path: [<String>], order: asc|desc}]
      consistencyLevel: ONE | QUORUM | ALL
      tenant: <String>        # multi-tenancy support
      <searchOperator>        # nearText, nearVector, hybrid, bm25, etc.
      where: <WhereFilter>
      groupBy: {path: [<String>], groups: <Int>, objectsPerGroup: <Int>}
    ) {
      <properties>
      _additional { ... }
    }
  }
}
```

### Currently Implemented

- `limit`, `offset`, `after` (cursor), `autocut`
- `sort` with path and order
- `consistencyLevel` (ONE, QUORUM, ALL)
- `where` filters
- `groupBy`
- Search operators: nearObject, nearVector, nearText, nearImage, hybrid, bm25, ask, group
- Additional properties: id, vector, generate, rerank, creationTimeUnix, lastUpdateTimeUnix, distance
- Additional sub-objects: classification, featureProjection

### Not Yet Implemented

- `tenant` parameter
- `targetVectors` (named vectors)
- Aggregate queries
- Explore queries
- New search operators (nearAudio, nearVideo, nearDepth, nearThermal, nearIMU)
- Hybrid fusion types
- New additional properties (score, explainScore, certainty, tokens, summary)

---

## Aggregate Queries

Aggregate queries compute metrics over collections without returning individual objects.

```graphql
{
  Aggregate {
    <Collection>(
      where: <WhereFilter>
      nearText: { concepts: [<String>] }
      nearVector: { vector: [<Float>] }
      nearObject: { id: <UUID> }
      objectLimit: <Int>       # limit objects before aggregation (with vector search)
      limit: <Int>             # limit number of groups
      groupBy: [<String>]      # group results by property path
      tenant: <String>
    ) {
      meta {
        count
      }
      <propertyName> {
        # Numeric properties (int, number):
        count
        minimum
        maximum
        mean
        median
        mode
        sum
        type

        # Text/string properties:
        count
        type
        topOccurrences(limit: <Int>) {
          value
          occurs
        }

        # Boolean properties:
        count
        type
        totalTrue
        totalFalse
        percentageTrue
        percentageFalse

        # Date properties:
        count
        minimum
        maximum
        median
        mode

        # Reference properties:
        pointingTo
        type
      }
    }
  }
}
```

### Aggregate with Vector Search

You can combine aggregation with vector search to aggregate over a subset of semantically relevant objects:

```graphql
{
  Aggregate {
    Article(
      nearText: { concepts: ["machine learning"] }
      objectLimit: 100
    ) {
      meta { count }
      wordCount {
        mean
        maximum
      }
    }
  }
}
```

### Aggregate with GroupBy

```graphql
{
  Aggregate {
    Article(groupBy: ["category"]) {
      groupedBy {
        path
        value
      }
      meta { count }
      wordCount { mean }
    }
  }
}
```

**Status:** Not yet implemented in `Noizu.Weaviate.GraphQL`.

---

## Explore Queries

Explore queries search across all collections using vector similarity, without specifying a target collection.

```graphql
{
  Explore(
    nearText: { concepts: [<String>] }
    nearVector: { vector: [<Float>] }
    nearObject: { id: <UUID> }
    limit: <Int>
    offset: <Int>
  ) {
    beacon
    certainty
    distance
    className
  }
}
```

**Status:** Not yet implemented in `Noizu.Weaviate.GraphQL`.

---

## Search Operators

### Vector Search

| Operator | Description | Key Parameters |
|----------|-------------|----------------|
| `nearText` | Semantic text search | `concepts`, `certainty`/`distance`, `moveTo`, `moveAwayFrom`, `targetVectors` |
| `nearVector` | Raw vector similarity | `vector`, `certainty`/`distance`, `targetVectors` |
| `nearObject` | Find similar to existing object | `id`, `certainty`/`distance`, `targetVectors` |
| `nearImage` | Image similarity search | `image` (base64), `certainty`/`distance`, `targetVectors` |
| `nearAudio` | Audio similarity search | `audio` (base64), `certainty`/`distance`, `targetVectors` |
| `nearVideo` | Video similarity search | `video` (base64), `certainty`/`distance`, `targetVectors` |
| `nearDepth` | Depth map similarity | `depth` (base64), `certainty`/`distance`, `targetVectors` |
| `nearThermal` | Thermal image similarity | `thermal` (base64), `certainty`/`distance`, `targetVectors` |
| `nearIMU` | IMU sensor data similarity | `imu` (base64), `certainty`/`distance`, `targetVectors` |

### Keyword Search

```graphql
bm25: {
  query: <String>
  properties: [<String>]    # optional: limit to specific properties
}
```

### Hybrid Search

Combines vector and keyword search:

```graphql
hybrid: {
  query: <String>
  alpha: <Float>              # 0 = pure keyword, 1 = pure vector (default: 0.75)
  vector: [<Float>]           # optional: provide custom vector
  properties: [<String>]      # optional: limit keyword search to properties
  fusionType: rankedFusion | relativeScoreFusion
  targetVectors: [<String>]   # for named vectors
  bm25SearchOperator: And | Or  # v1.31+ minimum token match control
}
```

**Fusion types:**
- `rankedFusion` (default before v1.24): Combines scores using reciprocal rank fusion
- `relativeScoreFusion` (default v1.24+): Normalizes and combines scores from each search

### Group (deprecated in favor of GroupBy)

```graphql
group: {
  type: merge | closest
  force: <Float>
}
```

### Currently Implemented Search Operators

nearText, nearVector, nearObject, nearImage, hybrid, bm25, ask, group

### Not Yet Implemented

nearAudio, nearVideo, nearDepth, nearThermal, nearIMU, hybrid fusionType/alpha/properties, targetVectors

---

## Where Filters

### Filter Operators

| Operator | Description | Value Types |
|----------|-------------|-------------|
| `Equal` | Exact match | All types |
| `NotEqual` | Not equal | All types |
| `GreaterThan` | Greater than | int, number, date |
| `GreaterThanEqual` | Greater than or equal | int, number, date |
| `LessThan` | Less than | int, number, date |
| `LessThanEqual` | Less than or equal | int, number, date |
| `Like` | Wildcard text match (? = single, * = multi) | text, string |
| `IsNull` | Null check | boolean |
| `WithinGeoRange` | Geo distance filter | geoCoordinates |
| `ContainsAny` | Array contains any of values | int[], number[], text[], boolean[], date[], uuid[] |
| `ContainsAll` | Array contains all values | int[], number[], text[], boolean[], date[], uuid[] |
| `ContainsNone` | Array contains none of values | int[], number[], text[], boolean[], date[], uuid[] |
| `And` | Logical AND | operands |
| `Or` | Logical OR | operands |
| `Not` | Logical NOT | operands (single-element array) |

### Value Types

| Value Type | GraphQL Field | Elixir Type |
|-----------|---------------|-------------|
| Int | `valueInt` | integer |
| Number | `valueNumber` | float |
| Boolean | `valueBoolean` | boolean |
| String | `valueString` | string (deprecated, use valueText) |
| Text | `valueText` | string |
| Date | `valueDate` | ISO 8601 string |
| GeoRange | `valueGeoRange` | `{latitude, longitude}` + distance |

### ContainsAny / ContainsAll Example

```graphql
where: {
  path: ["tags"]
  operator: ContainsAny
  valueText: ["elixir", "erlang"]
}
```

### Filter by Cross-Reference

```graphql
where: {
  path: ["inCategory", "Category", "name"]
  operator: Equal
  valueText: "Technology"
}
```

### Currently Implemented Filters

Equal, NotEqual, GreaterThan, GreaterThanEqual, LessThan, LessThanEqual, Like, IsNull, WithinGeoRange, And, Or

### Not Yet Implemented

ContainsAny, ContainsAll, ContainsNone, Not (logical negation), cross-reference path filtering, valueText (library uses valueString)

---

## Additional Properties

Additional properties are returned under `_additional` in Get query results.

```graphql
_additional {
  id                      # object UUID
  vector                  # the object's vector
  vectors {               # named vectors (v1.24+)
    <vectorName>
  }
  creationTimeUnix        # creation timestamp
  lastUpdateTimeUnix      # last update timestamp
  distance                # distance from search query
  certainty               # certainty score (cosine only)
  score                   # BM25/hybrid score
  explainScore            # explanation of score components

  # Classification
  classification {
    id
    basedOn
    classifiedFields
    completed
    scope
  }

  # Feature Projection (t-SNE / UMAP)
  featureProjection(
    dimensions: <Int>
    algorithm: <String>
    perplexity: <Int>
    learningRate: <Int>
    iterations: <Int>
  ) {
    vector
  }

  # Generative search (RAG)
  generate(
    singleResult: { prompt: <String> }
    groupedResult: { task: <String>, properties: [<String>] }
  ) {
    singleResult
    groupedResult
    error
  }

  # Reranking
  rerank(
    property: <String>
    query: <String>
  ) {
    score
  }

  # NER tokens
  tokens(
    properties: [<String>]
    certainty: <Float>
    limit: <Int>
  ) {
    entity
    property
    word
    certainty
    distance
    startPosition
    endPosition
  }

  # QnA Answer (from ask operator)
  answer {
    hasAnswer
    result
    certainty
    property
    startPosition
    endPosition
  }

  # Summarization
  summary(
    properties: [<String>]
  ) {
    property
    result
  }

  # GroupBy hit info
  group {
    id
    groupedBy { value path }
    count
    maxDistance
    minDistance
    hits {
      <properties>
      _additional { id distance vector }
    }
  }
}
```

### Currently Implemented Additional Properties

id, vector, generate, rerank, creationTimeUnix, lastUpdateTimeUnix, distance, classification, featureProjection

### Not Yet Implemented

vectors (named), certainty, score, explainScore, tokens, summary, group (groupBy hit details), generate with singleResult/groupedResult structure

---

## Sorting

Sort results by one or more properties:

```graphql
sort: [
  { path: ["propertyName"], order: asc }
  { path: ["propertyName2"], order: desc }
]
```

Sorting is available only for non-vector searches (no nearText, nearVector, etc.). You can sort by multiple properties - results are sorted by the first, then ties broken by the second, etc.

**Status:** Implemented in `Noizu.Weaviate.GraphQL.Get`.

---

## Pagination

### Offset-based

```graphql
Get {
  Article(limit: 10, offset: 20) { ... }
}
```

### Cursor-based

More efficient for large datasets:

```graphql
Get {
  Article(limit: 10, after: "last-object-uuid") { ... }
}
```

### Autocut

Automatically limit results based on score jumps. `autocut: 1` returns only the first "group" of similarly-scored results:

```graphql
Get {
  Article(
    nearText: { concepts: ["AI"] }
    autocut: 1
  ) { ... }
}
```

**Status:** All pagination methods implemented.

---

## GroupBy

Group results by a property value:

```graphql
Get {
  Article(
    nearText: { concepts: ["AI"] }
    groupBy: { path: ["category"], groups: 5, objectsPerGroup: 3 }
  ) {
    title
    _additional {
      group {
        id
        groupedBy { value path }
        count
        maxDistance
        minDistance
        hits {
          title
          _additional { id distance }
        }
      }
    }
  }
}
```

**Status:** GroupBy is implemented. The `_additional.group` hit detail structure is not yet implemented.

---

## Multi-Tenancy

Multi-tenant collections isolate data per tenant. Pass the `tenant` parameter in queries:

```graphql
{
  Get {
    Article(
      tenant: "tenantA"
      limit: 10
    ) {
      title
      content
    }
  }
}
```

```graphql
{
  Aggregate {
    Article(
      tenant: "tenantA"
    ) {
      meta { count }
    }
  }
}
```

**Status:** Not yet implemented in `Noizu.Weaviate.GraphQL`.

---

## Named Vectors

Collections can have multiple named vectors (v1.24+). Use `targetVectors` to specify which vector(s) to search:

```graphql
{
  Get {
    Article(
      nearText: {
        concepts: ["machine learning"]
        targetVectors: ["title_vector"]
      }
    ) {
      title
      _additional {
        vectors { title_vector content_vector }
        distance
      }
    }
  }
}
```

For hybrid search with named vectors:

```graphql
hybrid: {
  query: "machine learning"
  targetVectors: ["title_vector", "content_vector"]
  alpha: 0.5
}
```

**Status:** Not yet implemented in `Noizu.Weaviate.GraphQL`.

---

## Generative Search

Generative search (RAG) uses a language model to transform or generate text based on search results.

### Single Result (per-object generation)

```graphql
{
  Get {
    Article(nearText: { concepts: ["AI safety"] }, limit: 3) {
      title
      content
      _additional {
        generate(singleResult: { prompt: "Summarize this article: {content}" }) {
          singleResult
          error
        }
      }
    }
  }
}
```

Property names in curly braces `{propertyName}` are replaced with the object's property values.

### Grouped Result (all-results generation)

```graphql
{
  Get {
    Article(nearText: { concepts: ["AI safety"] }, limit: 5) {
      title
      content
      _additional {
        generate(
          groupedResult: {
            task: "Write a summary of these articles about AI safety"
            properties: ["title", "content"]
          }
        ) {
          groupedResult
          error
        }
      }
    }
  }
}
```

**Status:** Partially implemented. The `generate` additional property exists but the `singleResult`/`groupedResult` sub-structure is not yet built out.

---

## Reranking

Reranking re-scores search results using a reranker model:

```graphql
{
  Get {
    Article(
      nearText: { concepts: ["machine learning"] }
      limit: 20
    ) {
      title
      content
      _additional {
        rerank(property: "content", query: "deep learning applications") {
          score
        }
        distance
      }
    }
  }
}
```

**Status:** The `rerank` additional property key exists but the structured `property`/`query` parameters and `score` response are not yet implemented.
