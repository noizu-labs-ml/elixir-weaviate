defmodule WeaviateApi.Backups.CreateBackup do
  @moduledoc """
  Functions for creating a backup in Weaviate.
  """

  @doc """
  Create a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.
  - `include` (optional) - An optional list of class names to be included in the backup.
  - `exclude` (optional) - An optional list of class names to be excluded from the backup.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = WeaviateApi.Backups.CreateBackup.create_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
  """
  @spec create_backup(String.t(), String.t(), Keyword.t()) :: {:ok, any()} | {:error, any()}
  def create_backup(backend, backup_id, options \\ []) do
    # Construct the request URL
    url = "/v1/backups"

    # Prepare the backup parameters
    params = %{backend: backend, id: backup_id}
           |> Map.merge(options)

    # Make the API request to create the backup
    api_call(:post, url, params)
  end
end
