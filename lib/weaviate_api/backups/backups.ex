
defmodule Noizu.Weaviate.Api.Backups do
  @moduledoc """
  Functions for working with backups in Weaviate.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  #-------------------------------
  # Create Backup
  #-------------------------------
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
    url = weaviate_base() <> "backups"
    body = %{backend: backend, id: backup_id}
           |> put_field(:include, options)
           |> put_field(:exclude, options)

    api_call(:post, url, body, :json, nil)
  end

  #-------------------------------
  # Get Backup status
  #-------------------------------
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
    url = weaviate_base() <> "backups/#{backend}/#{backup_id}"
    api_call(:get, url, nil, :json, nil)
  end

  #-------------------------------
  # Restore Backup
  #-------------------------------
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
    url = weaviate_base() <> "backups/#{backend}/#{backup_id}/restore"
    body = %{}
           |> put_field(:include, options)
           |> put_field(:exclude, options)

    api_call(:post, url, body, :json, nil)
  end

  #-------------------------------
  # Get Restore Status
  #-------------------------------
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
    url = weaviate_base() <> "backups/#{backend}/#{backup_id}/restore"
    api_call(:get, url, nil, :json, nil)
  end
end


defmodule Noizu.Weaviate.Api.Batch do
  @moduledoc """
  Functions for batch operations in Weaviate.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  @doc """
  Batch create objects in Weaviate.

  ## Parameters

  - `objects` (required) - The list of objects to be created. Each object should be a map representing the object properties.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      object1 = %{
        "class": "Product",
        "properties": [
          %{"name": "title", "dataType": "string", "valueString": "Product 1"},
          %{
            "name": "price",
            "dataType": "number",
            "valueNumber": 10.99
          }
        ]
      }

      object2 = %{
        "class": "Product",
        "properties": [
          %{"name": "title", "dataType": "string", "valueString": "Product 2"},
          %{
            "name": "price",
            "dataType": "number",
            "valueNumber": 13.99
          }
        ]
      }

      objects = [object1, object2]

      {:ok, response} = Noizu.Weaviate.Api.Batch.create_objects(objects)
  """
  @spec create_objects([map()]) :: {:ok, any()} | {:error, any()}
  def create_objects(objects) do
    # Construct the request URL
    url = "/v1/batch/objects"

    # Construct the request body
    body = %{objects: objects}

    # Make the API request to batch create the objects
    Noizu.Weaviate.api_call(:post, url, body, Noizu.WeaviateStructs.BatchParams, nil)
  end

  @doc """
  Batch create references in Weaviate.

  ## Parameters

  - `references` (required) - The list of references to be created. Each reference should be a map with `from` and `to` properties representing the source and target objects.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      reference1 = %{
        "from": "weaviate://localhost/Product/1234",
        "to": "weaviate://localhost/Product/5678"
      }

      reference2 = %{
        "from": "weaviate://localhost/Product/1234",
        "to": "weaviate://localhost/Product/7890"
      }

      references = [reference1, reference2]

      {:ok, response} = Noizu.Weaviate.Api.Batch.create_references(references)
  """
  @spec create_references([map()]) :: {:ok, any()} | {:error, any()}
  def create_references(references) do
    # Construct the request URL
    url = "/v1/batch/references"

    # Construct the request body
    body = %{references: references}

    # Make the API request to batch create the references
    Noizu.Weaviate.api_call(:post, url, body, Noizu.WeaviateStructs.BatchParams, nil)
  end

  @doc """
  Batch delete objects in Weaviate.

  ## Parameters

  - `match` (required) - An object outlining how to identify the objects to be deleted. It should have the following keys:
    - `class` (required) - The class name as defined in the schema.
    - `where` (required) - The where filter object to find the objects to be deleted.
  - `output` (optional) - The verbosity level (`"minimal"` or `"verbose"`). Defaults to `"minimal"`.
  - `dry_run` (optional) - If true, objects will not be deleted yet, but merely listed. Defaults to false.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      match = %{
        "class": "Product",
        "where": %{"name": {"equals": "Product 1"}}
      }

      {:ok, response} = Noizu.Weaviate.Api.Batch.delete_objects(match)
  """
  @spec delete_objects(map(), String.t(), boolean()) :: {:ok, any()} | {:error, any()}
  def delete_objects(match, output \\ "minimal", dry_run \\ false) do
    # Construct the request URL
    url = "/v1/batch/objects"

    # Construct the request body
    body = %{
      match: match,
      output: output,
      dryRun: dry_run
    }

    # Make the API request to batch delete the objects
    Noizu.Weaviate.api_call(:delete, url, body, Noizu.WeaviateStructs.BatchParams, nil)
  end
end
