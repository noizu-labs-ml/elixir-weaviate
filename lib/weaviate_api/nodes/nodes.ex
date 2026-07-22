defmodule Noizu.Weaviate.Api.Nodes do
  @moduledoc """
  Functions for getting information about the Weaviate nodes.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  @doc """
  Get information about the Weaviate nodes.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Nodes.get_information_about_nodes()
  """
  @spec get_information_about_nodes(options :: any) :: {:ok, any()} | {:error, any()}
  # ⟦𓌆𓍺𓏝𓉗⟧ get_information_about_nodes :: Get information about the Weaviate nodes.
  def get_information_about_nodes(options \\ nil) do
    query_params =
      []
      |> then(& options[:output] && [{"output", options[:output]} | &1] || &1)
      |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    url = "#{Noizu.Weaviate.weaviate_base()}v1/nodes#{if query_params != "", do: "?" <> query_params, else: ""}"

    # NodeList
    Noizu.Weaviate.api_call(:get, url, nil, Noizu.Weaviate.Struct.Node, options)
  end

  @doc """
  Get nodes for a specific collection/class.

  ## Parameters

  - `class_name` (required) - The name of the class/collection.
  - `options` (optional) - Additional options for the API call. Supports `:output` ("minimal" or "verbose").

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Nodes.get_nodes_for_collection("Product")
      {:ok, response} = Noizu.Weaviate.Api.Nodes.get_nodes_for_collection("Product", output: "verbose")
  """
  @spec get_nodes_for_collection(String.t(), options :: any) :: {:ok, any()} | {:error, any()}
  # ⟦𓋸𓂡𓈒𓁵⟧ get_nodes_for_collection :: Get nodes for a specific collection/class.
  def get_nodes_for_collection(class_name, options \\ nil) do
    query_params =
      []
      |> then(& options[:output] && [{"output", options[:output]} | &1] || &1)
      |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    url = "#{Noizu.Weaviate.weaviate_base()}v1/nodes/#{class_name}#{if query_params != "", do: "?" <> query_params, else: ""}"

    Noizu.Weaviate.api_call(:get, url, nil, Noizu.Weaviate.Struct.Node, options)
  end
end
