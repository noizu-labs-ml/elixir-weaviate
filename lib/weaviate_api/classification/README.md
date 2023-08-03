# Noizu.Weaviate.Api.Classification

`Noizu.Weaviate.Api.Classification` is a module for performing classification related operations in Weaviate. Classification is a powerful feature in Weaviate that allows you to classify data objects by predicting cross-references based on the semantic meaning of the data objects.

## Start a Classification

Use the `start_classification/4` function to start a classification in Weaviate. This function sends a POST request to the `/v1/classification` endpoint and starts the classification process.

#### Parameters
- `class_name` (required): The name of the class of the data objects to be classified.
- `classify_properties` (required): A list of properties to classify.
- `based_on_properties` (required): A list of properties the classification is based on.
- `classification_type` (required): The type of classification to perform, either "knn" or "zeroshot".

#### Returns
- A tuple `{:ok, response}` on successful API call, where `response` is the API response.
- Returns `{:error, term}` on failure, where `term` contains error details.

#### Example
```elixir
{:ok, response} = Noizu.Weaviate.Api.Classification.start_classification("Product", ["name"], ["description"], "knn")
```

## Get Classification Status

Use the `get_classification_status/1` function to get the status, results, and metadata of a classification in Weaviate. This function sends a GET request to the `/v1/classifications/{id}` endpoint.

#### Parameters
- `classification_id` (required): The ID of the classification.

#### Returns
- A tuple `{:ok, response}` on successful API call, where `response` is the API response.
- Returns `{:error, term}` on failure, where `term` contains error details.

#### Example
```elixir
classification_id = "123456789"
{:ok, response} = Noizu.Weaviate.Api.Classification.get_classification_status(classification_id)
```

For more details on the `Noizu.Weaviate.Api.Classification` module and its functions, refer to the source code and documentation.
