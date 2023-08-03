defmodule Noizu.Weaviate.Api.Classification do
  @moduledoc """
  Module for performing classification related operations in Weaviate.
  """

  alias Noizu.Weaviate.HttpClient

  @doc """
  Get the status, results, and metadata of a classification in Weaviate.

  ## Parameters

  - `classification_id` (required) - The ID of the classification.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      classification_id = "123456789"

      {:ok, response} = Noizu.Weaviate.Api.Classification.get_classification_status(classification_id)
  """
  @spec get_classification_status(String.t()) :: {:ok, any()} | {:error, any()}
  def get_classification_status(classification_id) do
    url = "/v1/classifications/#{classification_id}"

    HttpClient.api_call(:get, url)
  end

  @doc """
  Start a classification in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class of the data objects to be classified.
  - `classify_properties` (required) - List of properties to classify.
  - `based_on_properties` (required) - List of properties the classification is based on.
  - `classification_type` (required) - The type of classification to perform, either "knn" or "zeroshot".

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Classification.start_classification("Product", ["name"], ["description"], "knn")
  """
  @spec start_classification(String.t(), [String.t()], [String.t()], String.t()) :: {:ok, any()} | {:error, any()}
  def start_classification(class_name, classify_properties, based_on_properties, classification_type) do
    url = "/v1/classification"

    params = %{
      class: class_name,
      classifyProperties: classify_properties,
      basedOnProperties: based_on_properties,
      type: classification_type
    }

    HttpClient.api_call(:post, url, params)
  end
end
