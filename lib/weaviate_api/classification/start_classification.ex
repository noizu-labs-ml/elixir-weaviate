defmodule WeaviateApi.Classification.StartClassification do
  @moduledoc """
  Functions for starting a classification in Weaviate.
  """

  @doc """
  Start a classification in Weaviate.

  ## Parameters

  - `class_name` (required) - The name of the class of the data objects to be classified.
  - `classify_properties` (required) - List of properties to classify.
  - `based_on_properties` (required) - List of properties the classification is based on.
  - `type` (required) - The type of classification to perform, either "knn" or "zeroshot".

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Classification.StartClassification.start_classification("Product", ["name"], ["description"], "knn")
  """
  @spec start_classification(String.t(), [String.t()], [String.t()], String.t()) :: {:ok, any()} | {:error, any()}
  def start_classification(class_name, classify_properties, based_on_properties, classification_type) do
    # Construct the request URL
    url = "/v1/classification"

    # Prepare the classification parameters
    params = %{
      class: class_name,
      classifyProperties: classify_properties,
      basedOnProperties: based_on_properties,
      type: classification_type
    }

    # Make the API request to start the classification
    api_call(:post, url, params)
  end
end
