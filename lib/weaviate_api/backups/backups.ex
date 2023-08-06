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

  A tuple `{:ok, response}` on successful API call, where `response` is of type `Noizu.Weaviate.Struct.RespObj`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.create_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
  """
  @spec create_backup(String.t(), String.t(), Keyword.t(), map()) ::
          {:ok, Noizu.Weaviate.Struct.RespObj} | {:error, any()}
  def create_backup(backend, backup_id, options \\ [], opts \\ %{}) do
    url = weaviate_base() <> "backups"

    body =
      %{backend: backend, id: backup_id}
      |> put_field(:include, options)
      |> put_field(:exclude, options)

    api_call(:post, url, body, Noizu.Weaviate.Struct.RespObj, opts)
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

  A tuple `{:ok, response}` on successful API call, where `response` is of type `Noizu.Weaviate.Struct.RespObj`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.get_status("s3", "my-backup")
  """
  @spec get_status(String.t(), String.t(), map()) ::
          {:ok, Noizu.Weaviate.Struct.RespObj} | {:error, any()}
  def get_status(backend, backup_id, opts \\ %{}) do
    url = weaviate_base() <> "backups/#{backend}/#{backup_id}"
    api_call(:get, url, nil, Noizu.Weaviate.Struct.RespObj, opts)
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

  A tuple `{:ok, response}` on successful API call, where `response` is of type `Noizu.Weaviate.Struct.RespObj`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.restore_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
  """
  @spec restore_backup(String.t(), String.t(), Keyword.t(), map()) ::
          {:ok, Noizu.Weaviate.Struct.RespObj} | {:error, any()}
  def restore_backup(backend, backup_id, options \\ [], opts \\ %{}) do
    url = weaviate_base() <> "backups/#{backend}/#{backup_id}/restore"

    body =
      %{}
      |> put_field(:include, options)
      |> put_field(:exclude, options)

    api_call(:post, url, body, Noizu.Weaviate.Struct.RespObj, opts)
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

  A tuple `{:ok, response}` on successful API call, where `response` is of type `Noizu.Weaviate.Struct.RespObj`.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Backups.get_restore_status("s3", "my-backup")
  """
  @spec get_restore_status(String.t(), String.t(), map()) ::
          {:ok, Noizu.Weaviate.Struct.RespObj} | {:error, any()}
  def get_restore_status(backend, backup_id, opts \\ []) do
    url = weaviate_base() <> "backups/#{backend}/#{backup_id}/restore"
    api_call(:get, url, nil, Noizu.Weaviate.Struct.RespObj, opts)
  end
end
