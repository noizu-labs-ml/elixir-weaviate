
defmodule Noizu.Weaviate do
  @moduledoc """
  Noizu.Weaviate is a library providing a simple wrapper around Weaviate's API calls.
  It handles various API features such as meta information, batch operations, backups,
  schema operations, nodes information, data objects, and classification.

  ## Configuration

  To configure the library, you need to set the Weaviate API key in your application's configuration:

      config :noizu_weaviate,
        weaviate_api_key: "your_api_key_here"
  """
  #-------------------------------
  # Global Types
  #-------------------------------
  @type error_tuple :: {:error, details :: term}

  # option constraints
  @type consistency_level_option() :: String.t()

  # common types
  @type api_response() :: {:ok, map()} | {:error, any()}

  # Common Type
  @type options() :: map()

  @weaviate_base "https://api.weaviate.com/v1/"

  require Finch

  def weaviate_base(), do: @weaviate_base

  #-------------------------------
  #
  #-------------------------------
  def api_call(type, url, body, options \\ %{}) do
    headers = headers(options)
    Finch.api_call(type, url, body, headers)
  end

  #-------------------------------
  #
  #-------------------------------
  defp headers(options) do
    [
      {"Content-Type", "application/json"},
      {"X-API-Key", Application.get_env(:noizu_weaviate, :weaviate_api_key)}
    ]
  end

  #-------------------------------
  #
  #-------------------------------
  def put_field(body, field, options, default \\ nil)
  def put_field(body, field, options, default) do
    if v = options[field] || default do
      Map.put(body, field, v)
    else
      body
    end
  end

  #-------------------------------
  #
  #-------------------------------
  def api_call_fetch(type, url, body, options) do
    headers = headers(options)
    Finch.api_call_fetch(type, url, body, headers)
  end

  #-------------------------------
  #
  #-------------------------------
  def api_call_stream(type, url, body, options) do
    headers = headers(options)
    callback = options[:stream] || nil
    Finch.api_call_stream(type, url, body, headers, callback)
  end
end
