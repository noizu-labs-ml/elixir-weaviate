# Weaviate Modules Reference

This document covers the available Weaviate vectorizer, generative, and reranker modules as of Weaviate v1.28+. It serves as a reference for configuring collections in `Noizu.Weaviate.Class`.

## Table of Contents

- [Vectorizer Modules](#vectorizer-modules)
- [Generative Modules](#generative-modules)
- [Reranker Modules](#reranker-modules)
- [Module Configuration](#module-configuration)

---

## Vectorizer Modules

### Text Vectorizers

| Module | Provider | Description |
|--------|----------|-------------|
| `text2vec-openai` | OpenAI | Uses OpenAI embedding models (text-embedding-3-small/large, ada-002) |
| `text2vec-cohere` | Cohere | Uses Cohere embed models (embed-english-v3.0, embed-multilingual-v3.0) |
| `text2vec-huggingface` | Hugging Face | Uses Hugging Face Inference API |
| `text2vec-transformers` | Self-hosted | Uses locally hosted transformer models |
| `text2vec-contextionary` | Weaviate | Weaviate's built-in contextionary (legacy) |
| `text2vec-palm` | Google | Uses Google PaLM/Gemini embedding models |
| `text2vec-aws` | AWS | Uses Amazon Bedrock embedding models (Titan, Cohere on Bedrock) |
| `text2vec-voyageai` | Voyage AI | Uses Voyage AI embedding models |
| `text2vec-jinaai` | Jina AI | Uses Jina AI embedding models |
| `text2vec-ollama` | Ollama | Uses locally hosted Ollama models |
| `text2vec-weaviate` | Weaviate | Weaviate Embeddings (WCD hosted) |
| `text2vec-octoai` | OctoAI | Uses OctoAI embedding endpoints |
| `text2vec-databricks` | Databricks | Uses Databricks Foundation Model APIs |

### Multi-Modal Vectorizers

| Module | Provider | Description |
|--------|----------|-------------|
| `multi2vec-clip` | Self-hosted | CLIP model for text + image |
| `multi2vec-bind` | Self-hosted | ImageBind for text + image + audio + video + depth + thermal + IMU |
| `multi2vec-palm` | Google | Google multimodal embeddings |
| `multi2vec-cohere` | Cohere | Cohere multimodal embeddings |

### Other Vectorizers

| Module | Provider | Description |
|--------|----------|-------------|
| `img2vec-neural` | Self-hosted | Image-only vectorizer (ResNet-based) |
| `ref2vec-centroid` | Built-in | Computes vector as centroid of referenced objects |
| `none` | - | No vectorizer; bring your own vectors |

---

## Generative Modules

Generative modules enable RAG (Retrieval-Augmented Generation) via GraphQL `_additional.generate`.

| Module | Provider | Models |
|--------|----------|--------|
| `generative-openai` | OpenAI | gpt-4o, gpt-4o-mini, gpt-4-turbo, gpt-3.5-turbo |
| `generative-cohere` | Cohere | command-r-plus, command-r, command |
| `generative-palm` | Google | gemini-1.5-pro, gemini-1.5-flash, gemini-pro |
| `generative-aws` | AWS | Bedrock models (Claude, Titan, Llama on Bedrock) |
| `generative-ollama` | Ollama | Any locally hosted model |
| `generative-anyscale` | Anyscale | Open-source models via Anyscale |
| `generative-mistral` | Mistral AI | mistral-large, mistral-medium, mistral-small |
| `generative-anthropic` | Anthropic | Claude models |
| `generative-databricks` | Databricks | Databricks Foundation Model APIs |
| `generative-friendliai` | FriendliAI | FriendliAI hosted models |
| `generative-octoai` | OctoAI | OctoAI hosted models |

### Generative Module Configuration

```json
{
  "moduleConfig": {
    "generative-openai": {
      "model": "gpt-4o",
      "temperatureProperty": 0.7,
      "maxTokensProperty": 1000,
      "frequencyPenaltyProperty": 0,
      "presencePenaltyProperty": 0,
      "topPProperty": 1
    }
  }
}
```

---

## Reranker Modules

Reranker modules re-score search results for better relevance via `_additional.rerank`.

| Module | Provider | Models |
|--------|----------|--------|
| `reranker-cohere` | Cohere | rerank-english-v3.0, rerank-multilingual-v3.0, rerank-english-v2.0 |
| `reranker-voyageai` | Voyage AI | rerank-2, rerank-lite-1 |
| `reranker-transformers` | Self-hosted | Locally hosted cross-encoder models |
| `reranker-jinaai` | Jina AI | jina-reranker-v2-base-multilingual |

### Reranker Module Configuration

```json
{
  "moduleConfig": {
    "reranker-cohere": {
      "model": "rerank-english-v3.0"
    }
  }
}
```

---

## Module Configuration

### Per-Collection Configuration

Modules are configured at the collection level in `moduleConfig`:

```json
{
  "class": "Article",
  "vectorizer": "text2vec-openai",
  "moduleConfig": {
    "text2vec-openai": {
      "model": "text-embedding-3-small",
      "dimensions": 1536,
      "type": "text"
    },
    "generative-openai": {
      "model": "gpt-4o"
    },
    "reranker-cohere": {
      "model": "rerank-english-v3.0"
    }
  },
  "properties": [
    {
      "name": "title",
      "dataType": ["text"],
      "moduleConfig": {
        "text2vec-openai": {
          "skip": false,
          "vectorizePropertyName": true
        }
      }
    }
  ]
}
```

### Per-Property Vectorizer Configuration

Each property can configure how it interacts with the vectorizer:

| Option | Type | Description |
|--------|------|-------------|
| `skip` | boolean | If true, property is not included in vectorization |
| `vectorizePropertyName` | boolean | If true, property name is included in the text to vectorize |

### Named Vectors Configuration

Collections can have multiple named vectors, each with its own vectorizer and index:

```json
{
  "class": "Article",
  "vectorConfig": {
    "title_vector": {
      "vectorizer": {
        "text2vec-openai": {
          "properties": ["title"],
          "model": "text-embedding-3-small"
        }
      },
      "vectorIndexType": "hnsw",
      "vectorIndexConfig": {
        "distance": "cosine"
      }
    },
    "content_vector": {
      "vectorizer": {
        "text2vec-cohere": {
          "properties": ["content"],
          "model": "embed-english-v3.0"
        }
      },
      "vectorIndexType": "flat"
    }
  }
}
```

**Status:** Named vectors and `vectorConfig` are not yet supported in `Noizu.Weaviate.Class`. The library currently supports a single `vectorizer` and `vectorIndexConfig` per collection.
