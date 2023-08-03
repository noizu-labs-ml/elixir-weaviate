# Noizu.Weaviate.Api.Backups

`Noizu.Weaviate.Api.Backups` is a module that provides functions for working with backups in Weaviate. With these functions, you can create a backup, get the status of a backup, restore a backup, and check the status of a restore operation.

## Create a Backup

The `create_backup/3` function sends a `POST` request to `/v1/backups` in Weaviate to create a backup. It requires the following parameters:

- `backend` (required): The name of the backup provider module.
- `backup_id` (required): The ID of the backup.
- `include` (optional): An optional list of class names to be included in the backup.
- `exclude` (optional): An optional list of class names to be excluded from the backup.

Example usage:

```elixir
{:ok, response} = Noizu.Weaviate.Api.Backups.create_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
```

## Get the Status of a Backup

The `get_status/2` function sends a `GET` request to `/v1/backups/{backend}/{backup_id}` in Weaviate to get the status of a backup. It requires the following parameters:

- `backend` (required): The name of the backup provider module.
- `backup_id` (required): The ID of the backup.

Example usage:

```elixir
{:ok, response} = Noizu.Weaviate.Api.Backups.get_status("s3", "my-backup")
```

## Restore a Backup

The `restore_backup/3` function sends a `POST` request to `/v1/backups/{backend}/{backup_id}/restore` in Weaviate to restore a backup. It requires the following parameters:

- `backend` (required): The name of the backup provider module.
- `backup_id` (required): The ID of the backup.
- `include` (optional): An optional list of class names to be included in the restore.
- `exclude` (optional): An optional list of class names to be excluded from the restore.

Example usage:

```elixir
{:ok, response} = Noizu.Weaviate.Api.Backups.restore_backup("s3", "my-backup", include: ["Product"], exclude: ["User"])
```

## Get the Status of a Restore Operation

The `get_restore_status/2` function sends a `GET` request to `/v1/backups/{backend}/{backup_id}/restore` in Weaviate to get the status of a restore operation. It requires the following parameters:

- `backend` (required): The name of the backup provider module.
- `backup_id` (required): The ID of the backup.

Example usage:

```elixir
{:ok, response} = Noizu.Weaviate.Api.Backups.get_restore_status("s3", "my-backup")
```

For more details on the functions in the `Noizu.Weaviate.Api.Backups` module and their parameters, refer to the source code and documentation.

## More Resources

- [Weaviate Documentation: Backups](https://www.semi.technology/documentation/weaviate/current/restful-apis/schema.html)
- [Weaviate Documentation: Schema](https://www.semi.technology/documentation/weaviate/current/concepts/schema.html)
- [Weaviate Documentation: REST API: Schema](https://www.semi.technology/documentation/weaviate/current/restful-apis/schema.html)
