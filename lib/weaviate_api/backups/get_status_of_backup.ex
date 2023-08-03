defmodule WeaviateApi.Backups.GetStatusOfBackup do
  @moduledoc """
  Functions for getting the status of a backup in Weaviate.
  """

  @doc """
  Get the status of a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Backups.GetStatusOfBackup.get_status("s3", "my-backup")
  """
  @spec get_status(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def get_status(backend, backup_id) do
    # Construct the request URL
    url = "/v1/backups/#{backend}/#{backup_id}"

    # Make the API request to get the status of the backup
    api_call(:get, url)
  end
end
