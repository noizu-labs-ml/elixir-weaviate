defmodule WeaviateApi.Backups.RestoreBackup do
  @moduledoc """
  Functions for restoring a backup in Weaviate.
  """

  @doc """
  Restore a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.
  - `include` (optional) - An optional list of class names to be included in the restore.
  - `exclude` (optional) - An optional list of class names to be excluded from the restore.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Backups.RestoreBackup.restore_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
  """
  @spec restore_backup(String.t(), String.t(), Keyword.t()) :: {:ok, any()} | {:error, any()}
  def restore_backup(backend, backup_id, options \\ []) do
    # Construct the request URL
    url = "/v1/backups/#{backend}/#{backup_id}/restore"

    # Prepare the restore parameters
    params = %{}
           |> Map.merge(options)

    # Make the API request to restore the backup
    api_call(:post, url, params)
  end
end
