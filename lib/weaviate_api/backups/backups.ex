defmodule Noizu.Weaviate.Api.Backups do
  @moduledoc """
  Functions for working with backups in Weaviate.
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

      {:ok, response} = Noizu.Weaviate.Api.Backups.create_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
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

  @doc """
  Get the status of a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.get_status("s3", "my-backup")
  """
  @spec get_status(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def get_status(backend, backup_id) do
    # Construct the request URL
    url = "/v1/backups/#{backend}/#{backup_id}"

    # Make the API request to get the status of the backup
    api_call(:get, url)
  end

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

      {:ok, response} = Noizu.Weaviate.Api.Backups.restore_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
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

  @doc """
  Get the status of a restore operation in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.get_restore_status("s3", "my-backup")
  """
  @spec get_restore_status(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def get_restore_status(backend, backup_id) do
    # Construct the request URL
    url = "/v1/backups/#{backend}/#{backup_id}/restore"

    # Make the API request to get the status of the restore operation
    api_call(:get, url)
  end
end
