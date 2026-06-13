# Weaviate REST API Reference

This document covers the full Weaviate REST API surface as of Weaviate v1.28+. It serves as a reference for current and planned `Noizu.Weaviate.Api` module coverage.

## Table of Contents

- [Schema / Collections](#schema--collections)
- [Objects](#objects)
- [Batch Operations](#batch-operations)
- [Backups](#backups)
- [Classification](#classification)
- [Nodes](#nodes)
- [Meta](#meta)
- [Well-Known / Auth](#well-known--auth)
- [Cluster](#cluster)
- [RBAC / Authorization](#rbac--authorization)
- [Multi-Tenancy](#multi-tenancy)

---

## Schema / Collections

Weaviate v1.25+ introduces the "collections" terminology (replacing "classes"), though the v1 REST API paths remain under `/v1/schema`.

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/schema` | Get entire schema | Implemented |
| `POST` | `/v1/schema` | Create a collection (class) | Implemented |
| `GET` | `/v1/schema/{className}` | Get a collection | Implemented |
| `PUT` | `/v1/schema/{className}` | Update a collection | Implemented |
| `DELETE` | `/v1/schema/{className}` | Delete a collection | Implemented |
| `POST` | `/v1/schema/{className}/properties` | Add a property | Implemented |
| `GET` | `/v1/schema/{className}/shards` | Get shards | Implemented |
| `PUT` | `/v1/schema/{className}/shards/{shardName}` | Update shard status | Implemented |
| `GET` | `/v1/schema/{className}/tenants` | List tenants | Implemented |
| `POST` | `/v1/schema/{className}/tenants` | Add tenants | Implemented |
| `PUT` | `/v1/schema/{className}/tenants` | Update tenants | Implemented |
| `DELETE` | `/v1/schema/{className}/tenants` | Remove tenants | Implemented |

### Collection Configuration (v1.25+)

Collections now support these configuration areas:

```json
{
  "class": "Article",
  "description": "...",
  "vectorizer": "text2vec-openai",
  "moduleConfig": { ... },

  "vectorConfig": {
    "title_vector": {
      "vectorizer": { "text2vec-openai": { "properties": ["title"] } },
      "vectorIndexType": "hnsw",
      "vectorIndexConfig": { ... }
    },
    "content_vector": {
      "vectorizer": { "text2vec-openai": { "properties": ["content"] } },
      "vectorIndexType": "flat"
    }
  },

  "properties": [ ... ],

  "invertedIndexConfig": {
    "bm25": { "b": 0.75, "k1": 1.2 },
    "stopwords": { "preset": "en", "additions": [], "removals": [] },
    "indexTimestamps": false,
    "indexNullState": false,
    "indexPropertyLength": false
  },

  "replicationConfig": {
    "factor": 1,
    "asyncEnabled": false
  },

  "shardingConfig": {
    "desiredCount": 1,
    "virtualPerPhysical": 128
  },

  "multiTenancyConfig": {
    "enabled": false,
    "autoTenantCreation": false,
    "autoTenantActivation": false
  }
}
```

### Property Types

| Type | Description | New in |
|------|-------------|--------|
| `text` | Text, tokenized for search | - |
| `text[]` | Array of text | - |
| `int` | Integer | - |
| `int[]` | Array of integers | - |
| `number` | Float | - |
| `number[]` | Array of floats | - |
| `boolean` | Boolean | - |
| `boolean[]` | Array of booleans | - |
| `date` | ISO 8601 date | - |
| `date[]` | Array of dates | - |
| `uuid` | UUID string | v1.19+ |
| `uuid[]` | Array of UUIDs | v1.19+ |
| `geoCoordinates` | Lat/lon coordinates | - |
| `phoneNumber` | Phone number | - |
| `blob` | Base64 encoded binary | - |
| `object` | Nested object | v1.22+ |
| `object[]` | Array of nested objects | v1.22+ |
| `crossReference` | Cross-reference to another object | - |

### Nested Properties (object/object[])

```json
{
  "name": "address",
  "dataType": ["object"],
  "nestedProperties": [
    { "name": "street", "dataType": ["text"] },
    { "name": "city", "dataType": ["text"] },
    { "name": "zip", "dataType": ["int"] }
  ]
}
```

**Status:** Object/object[] types and nested properties not yet supported in `Noizu.Weaviate.Class`.

### Vector Index Types

| Type | Description | Use Case |
|------|-------------|----------|
| `hnsw` | Hierarchical Navigable Small World | General purpose, best recall |
| `flat` | Brute-force flat index | Small collections (<10k vectors) |
| `dynamic` | Starts flat, switches to HNSW at threshold | Collections that grow |

#### HNSW Configuration

```json
{
  "vectorIndexType": "hnsw",
  "vectorIndexConfig": {
    "ef": -1,
    "efConstruction": 128,
    "maxConnections": 32,
    "dynamicEfMin": 100,
    "dynamicEfMax": 500,
    "dynamicEfFactor": 8,
    "flatSearchCutoff": 40000,
    "skip": false,
    "distance": "cosine",
    "pq": {
      "enabled": false,
      "segments": 0,
      "centroids": 256,
      "encoder": { "type": "kmeans", "distribution": "log-normal" },
      "trainingLimit": 100000
    },
    "bq": { "enabled": false },
    "sq": {
      "enabled": false,
      "trainingLimit": 100000,
      "rescoreLimit": 20
    }
  }
}
```

**Quantization options:**
- **PQ** (Product Quantization): Compresses vectors into smaller codes. Good for large datasets.
- **BQ** (Binary Quantization): Reduces each dimension to 1 bit. Fastest, lowest memory.
- **SQ** (Scalar Quantization): Reduces each dimension to 1 byte. Good balance of speed/recall.

#### Flat Configuration

```json
{
  "vectorIndexType": "flat",
  "vectorIndexConfig": {
    "distance": "cosine",
    "bq": { "enabled": true }
  }
}
```

#### Dynamic Configuration

```json
{
  "vectorIndexType": "dynamic",
  "vectorIndexConfig": {
    "threshold": 10000,
    "distance": "cosine",
    "hnsw": { ... },
    "flat": { ... }
  }
}
```

**Status:** Library currently only documents HNSW. Flat, dynamic, and quantization (PQ/BQ/SQ) configs not yet supported.

---

## Objects

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/objects` | List objects | Implemented |
| `POST` | `/v1/objects` | Create object | Implemented |
| `GET` | `/v1/objects/{className}/{id}` | Get object | Implemented |
| `PUT` | `/v1/objects/{className}/{id}` | Replace object | Implemented |
| `PATCH` | `/v1/objects/{className}/{id}` | Update object (partial) | Implemented |
| `DELETE` | `/v1/objects/{className}/{id}` | Delete object | Implemented |
| `HEAD` | `/v1/objects/{className}/{id}` | Check object existence | Not implemented |
| `POST` | `/v1/objects/validate` | Validate object | Implemented |
| `POST` | `/v1/objects/{className}/{id}/references/{propertyName}` | Add reference | Not implemented |
| `PUT` | `/v1/objects/{className}/{id}/references/{propertyName}` | Replace references | Not implemented |
| `DELETE` | `/v1/objects/{className}/{id}/references/{propertyName}` | Delete reference | Not implemented |

### Query Parameters

| Parameter | Description | Status |
|-----------|-------------|--------|
| `consistency_level` | ONE, QUORUM, ALL | Implemented |
| `tenant` | Tenant name for multi-tenant collections | Not implemented |
| `include` | Additional properties to include (e.g., `vector`, `classification`) | Implemented |
| `node_name` | Target a specific node | Not implemented |

### Named Vectors in Objects

With named vectors, the object body includes a `vectors` field:

```json
{
  "class": "Article",
  "properties": { "title": "...", "content": "..." },
  "vectors": {
    "title_vector": [0.1, 0.2, ...],
    "content_vector": [0.3, 0.4, ...]
  }
}
```

**Status:** Named vectors not yet supported in object create/update.

---

## Batch Operations

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `POST` | `/v1/batch/objects` | Batch create objects | Implemented |
| `POST` | `/v1/batch/references` | Batch create references | Implemented |
| `DELETE` | `/v1/batch/objects` | Batch delete objects | Implemented |

### Batch Create Options

```json
{
  "objects": [...],
  "fields": ["ALL"]
}
```

**Headers:**
- `X-Weaviate-Consistency-Level`: ONE, QUORUM, ALL (default: QUORUM)

**Status:** Consistency level header not yet implemented in batch operations.

---

## Backups

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `POST` | `/v1/backups/{backend}` | Create backup | Implemented |
| `GET` | `/v1/backups/{backend}/{id}` | Get backup status | Implemented |
| `POST` | `/v1/backups/{backend}/{id}/restore` | Restore backup | Implemented |
| `GET` | `/v1/backups/{backend}/{id}/restore` | Get restore status | Implemented |

### Supported Backends

- `filesystem` - Local filesystem
- `s3` - Amazon S3
- `gcs` - Google Cloud Storage
- `azure` - Azure Blob Storage

### Node-Level Backups (v1.28+)

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `POST` | `/v1/backups/{backend}?node={nodeName}` | Create node-level backup | Not implemented |

---

## Classification

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `POST` | `/v1/classifications` | Start classification | Implemented |
| `GET` | `/v1/classifications/{id}` | Get classification status | Implemented |

### Classification Types

- `knn` - k-Nearest Neighbors
- `zeroshot` - Zero-shot classification
- `text2vec-contextionary` - Contextionary-based (deprecated)

---

## Nodes

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/nodes` | Get all nodes info | Implemented |
| `GET` | `/v1/nodes/{className}` | Get nodes for a collection | Not implemented |

### Node Info Response

```json
{
  "nodes": [
    {
      "name": "node-0",
      "status": "HEALTHY",
      "version": "1.28.0",
      "gitHash": "...",
      "stats": {
        "objectCount": 12345,
        "shardCount": 3
      },
      "shards": [
        {
          "name": "shard-abc",
          "class": "Article",
          "objectCount": 4115,
          "vectorQueueLength": 0
        }
      ]
    }
  ]
}
```

---

## Meta

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/meta` | Get server meta info | Implemented |

### Response

```json
{
  "hostname": "http://[::]:8080",
  "version": "1.28.0",
  "modules": {
    "text2vec-openai": { ... },
    "generative-openai": { ... }
  }
}
```

---

## Well-Known / Auth

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/.well-known/openid-configuration` | Get OIDC config | Implemented |
| `GET` | `/v1/.well-known/live` | Liveness probe | Implemented |
| `GET` | `/v1/.well-known/ready` | Readiness probe | Implemented |

---

## Cluster

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/cluster/statistics` | Get cluster statistics | Not implemented |

---

## RBAC / Authorization

Weaviate v1.28+ supports role-based access control (RBAC).

### Endpoints

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/authz/roles` | List all roles | Not implemented |
| `POST` | `/v1/authz/roles` | Create a role | Not implemented |
| `GET` | `/v1/authz/roles/{roleName}` | Get a role | Not implemented |
| `DELETE` | `/v1/authz/roles/{roleName}` | Delete a role | Not implemented |
| `POST` | `/v1/authz/roles/{roleName}/add-permissions` | Add permissions to role | Not implemented |
| `POST` | `/v1/authz/roles/{roleName}/remove-permissions` | Remove permissions from role | Not implemented |
| `GET` | `/v1/authz/roles/{roleName}/users` | Get users assigned to role | Not implemented |
| `POST` | `/v1/authz/users/{userId}/assign` | Assign roles to user | Not implemented |
| `POST` | `/v1/authz/users/{userId}/revoke` | Revoke roles from user | Not implemented |
| `GET` | `/v1/authz/users/{userId}/roles` | Get roles for user | Not implemented |

### RBAC Permission Structure

```json
{
  "name": "article-reader",
  "permissions": [
    {
      "action": "read_data",
      "collection": "Article"
    },
    {
      "action": "read_schema",
      "collection": "*"
    }
  ]
}
```

### Available Actions

- `manage_roles` - Manage RBAC roles
- `read_schema` - Read collection schemas
- `create_schema` - Create collections
- `update_schema` - Update collection config
- `delete_schema` - Delete collections
- `read_data` - Read objects
- `create_data` - Create objects
- `update_data` - Update objects
- `delete_data` - Delete objects
- `manage_backups` - Manage backups
- `manage_cluster` - Manage cluster operations

---

## Multi-Tenancy

### Tenant Operations

Tenants are managed through the Schema API:

| Method | Path | Description | Status |
|--------|------|-------------|--------|
| `GET` | `/v1/schema/{className}/tenants` | List tenants | Implemented |
| `POST` | `/v1/schema/{className}/tenants` | Add tenants | Implemented |
| `PUT` | `/v1/schema/{className}/tenants` | Update tenants | Implemented |
| `DELETE` | `/v1/schema/{className}/tenants` | Remove tenants | Implemented |

### Tenant States

| State | Description | New in |
|-------|-------------|--------|
| `ACTIVE` | Tenant data loaded and queryable | - |
| `INACTIVE` | Tenant data stored locally but not loaded | v1.21+ |
| `OFFLOADED` | Tenant data moved to cloud storage | v1.26+ |

### Tenant Create/Update Body

```json
[
  { "name": "tenantA", "activityStatus": "ACTIVE" },
  { "name": "tenantB", "activityStatus": "INACTIVE" }
]
```

### Auto-Tenant Creation (v1.25+)

When `autoTenantCreation` is enabled in the collection config, tenants are automatically created when data is inserted for a non-existent tenant.

### Auto-Tenant Activation (v1.27+)

When `autoTenantActivation` is enabled, inactive/offloaded tenants are automatically activated when queried.

**Status:** Tenant CRUD is implemented. Tenant states (INACTIVE, OFFLOADED) and auto-tenant configuration are not yet supported in the library structs.
