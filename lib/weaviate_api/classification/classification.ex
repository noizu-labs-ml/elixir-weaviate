defmodule Noizu.Weaviate.Api.Classification do
  @moduledoc """
  Functions for classification operations in Weaviate.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  @doc """
  Get the status, results, and metadata of a classification in Weaviate.

    ## Parameters

    - `classification_id` (required) - The ID of the classification.
    - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      classification_id = "123456789"

      {:ok, response} = Noizu.Weaviate.Api.Classification.get_classification_status(classification_id)
  """
  @type classification_response() :: map()
  @type classification_options() ::
          %{
            optional(:stream) => Noizu.Weaviate.stream_option()
          }
          | Keyword.t()

  @spec get_classification_status(String.t(), options :: any) ::
          {:ok, classification_response()} | {:error, any()}
  def get_classification_status(classification_id, options \\ nil) do
    url = "#{weaviate_base()}/classifications/#{classification_id}"
    api_call(:get, url, nil, Noizu.Weaviate.Struct.RespObj, options)
  end

  @doc """
  Start a classification in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class of the data objects to be classified.
  - `classify_properties` (required) - List of properties to classify.
  - `based_on_properties` (required) - List of properties the classification is based on.
  - `classification_type` (required) - The type of classification to perform, either "knn" or "zeroshot".
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Classification.start_classification("Product", ["name"], ["description"], "knn")
  """
  @type classification_start_response() :: map()
  @type classification_start_options() ::
          %{
            optional(:stream) => Noizu.Weaviate.stream_option()
          }
          | Keyword.t()

  @spec start_classification(String.t(), [String.t()], [String.t()], String.t(), options :: any) ::
          {:ok, classification_start_response()} | {:error, any()}
  def start_classification(
        class_name,
        classify_properties,
        based_on_properties,
        classification_type,
        options \\ nil
      ) do
    url = "#{weaviate_base()}/classification"

    body = %{
      class_name: class_name,
      classify_properties: classify_properties,
      based_on_properties: based_on_properties,
      classification_type: classification_type
    }

    api_call(:post, url, body, Noizu.Weaviate.Struct.RespObj, options)
  end
end
