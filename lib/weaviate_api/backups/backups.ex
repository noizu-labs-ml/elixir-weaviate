defmodule Noizu.Weaviate.Api.Backups do
  @moduledoc """
  Functions for working with backups in Weaviate.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  # -------------------------------
  # Create Backup
  # -------------------------------
  @doc """
  Create a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.
  - `include` (optional) - An optional list of class names to be included in the backup.
  - `exclude` (optional) - An optional list of class names to be excluded from the backup.
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is of type `:json`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.create_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
  """
  @spec create_backup(String.t(), String.t(), Keyword.t(), map()) ::
          {:ok, :json} | {:error, any()}
  # ⟦𓇌𓋴𓀊𓄵⟧ create_backup :: auto-generated pointer for public function create_backup
  def create_backup(backend, backup_id, options \\ [], opts \\ %{}) do
    url = weaviate_base() <> "v1/backups"

    body =
      %{backend: backend, id: backup_id}
      |> put_field(:include, options)
      |> put_field(:exclude, options)

    api_call(:post, url, body, :json, opts)
  end

  # -------------------------------
  # Get Backup status
  # -------------------------------
  @doc """
  Get the status of a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is of type `:json`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.get_status("s3", "my-backup")
  """
  @spec get_status(String.t(), String.t(), map()) ::
          {:ok, :json} | {:error, any()}
  # ⟦𓎮𓆀𓏉𓐩⟧ get_status :: auto-generated pointer for public function get_status
  def get_status(backend, backup_id, opts \\ %{}) do
    url = weaviate_base() <> "v1/backups/#{backend}/#{backup_id}"
    api_call(:get, url, nil, :json, opts)
  end

  # -------------------------------
  # Restore Backup
  # -------------------------------
  @doc """
  Restore a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.
  - `include` (optional) - An optional list of class names to be included in the restore.
  - `exclude` (optional) - An optional list of class names to be excluded from the restore.
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is of type `:json`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.restore_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
  """
  @spec restore_backup(String.t(), String.t(), Keyword.t(), map()) ::
          {:ok, :json} | {:error, any()}
  # ⟦𓃘𓉏𓐜𓌐⟧ restore_backup :: auto-generated pointer for public function restore_backup
  def restore_backup(backend, backup_id, options \\ [], opts \\ %{}) do
    url = weaviate_base() <> "v1/backups/#{backend}/#{backup_id}/restore"

    body =
      %{}
      |> put_field(:include, options)
      |> put_field(:exclude, options)

    api_call(:post, url, body, :json, opts)
  end

  # -------------------------------
  # Get Restore Status
  # -------------------------------
  @doc """
  Get the status of a restore operation in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup.
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is of type `:json`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.get_restore_status("s3", "my-backup")
  """
  @spec get_restore_status(String.t(), String.t(), map()) ::
          {:ok, :json} | {:error, any()}
  # ⟦𓂪𓄒𓌛𓌮⟧ get_restore_status :: auto-generated pointer for public function get_restore_status
  def get_restore_status(backend, backup_id, opts \\ []) do
    url = weaviate_base() <> "v1/backups/#{backend}/#{backup_id}/restore"
    api_call(:get, url, nil, :json, opts)
  end

  # -------------------------------
  # List Backups
  # -------------------------------
  @doc """
  List all backups for a given backend.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.list_backups("s3")
  """
  @spec list_backups(String.t(), map()) ::
          {:ok, any()} | {:error, any()}
  # ⟦𓍮𓎚𓆚𓉺⟧ list_backups :: auto-generated pointer for public function list_backups
  def list_backups(backend, options \\ nil) do
    url = weaviate_base() <> "v1/backups/#{backend}"
    api_call(:get, url, nil, :json, options)
  end

  # -------------------------------
  # Cancel Backup
  # -------------------------------
  @doc """
  Cancel a backup in Weaviate.

  ## Parameters

  - `backend` (required) - The name of the backup provider module.
  - `backup_id` (required) - The ID of the backup to cancel.
  - `options` (optional) - Additional options for the API call.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.cancel_backup("s3", "my-backup")
  """
  @spec cancel_backup(String.t(), String.t(), map()) ::
          {:ok, any()} | {:error, any()}
  # ⟦𓎃𓀫𓊹𓂛⟧ cancel_backup :: auto-generated pointer for public function cancel_backup
  def cancel_backup(backend, backup_id, options \\ nil) do
    url = weaviate_base() <> "v1/backups/#{backend}/#{backup_id}"
    api_call(:delete, url, nil, :json, options)
  end
end
