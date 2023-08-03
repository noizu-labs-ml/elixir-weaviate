# Weaviate Elixir API Wrapper

Weaviate Elixir API Wrapper library provides a convenient way to interact with the Weaviate REST API using Elixir.

## Installation

To install the Weaviate Elixir API Wrapper, add the following to your `mix.exs` file:

```elixir
defp deps do
  [
    {:weaviate_api, "~> 0.1.0"}
  ]
end
```

Then, run `mix deps.get` to fetch the dependency.

## Configuration

To configure the Weaviate Elixir API Wrapper, add the following to your `config.exs` or the appropriate environment-specific config file:

```elixir
config :weaviate_api,
  base_url: "https://example.com",
  api_key: "your_weaviate_api_key"
```

Replace `"https://example.com"` with your actual Weaviate base URL, and `"your_weaviate_api_key"` with your Weaviate API key.

## Usage

The Weaviate Elixir API Wrapper provides modules for different Weaviate API endpoints:

- [WeaviateApi.Schema.CreateOrUpdateClass](lib/weaviate_api/schema/create_or_update_class.ex)
- [WeaviateApi.Schema.ConfigureClass](lib/weaviate_api/schema/configure_class.ex)
- [WeaviateApi.Schema.AddPropertyToClass](lib/weaviate_api/schema/add_property_to_class.ex)
- [WeaviateApi.Schema.ConfigurePropertyOfClass](lib/weaviate_api/schema/configure_property_of_class.ex)
- [WeaviateApi.Schema.ConfigureVectorIndices](lib/weaviate_api/schema/configure_vector_indices.ex)
- [WeaviateApi.Schema.ConfigureInvertedIndex](lib/weaviate_api/schema/configure_inverted_index.ex)
- [WeaviateApi.Schema.ConfigureStopwords](lib/weaviate_api/schema/configure_stopwords.ex)
- [WeaviateApi.Schema.ConfigureReplication](lib/weaviate_api/schema/configure_replication.ex)
- [WeaviateApi.Objects.ListDataObjects](lib/weaviate_api/objects/list_data_objects.ex)
- [WeaviateApi.Objects.CreateDataObject](lib/weaviate_api/objects/create_data_object.ex)
- [WeaviateApi.Objects.GetDataObject](lib/weaviate_api/objects/get_data_object.ex)
- [WeaviateApi.Objects.CheckIfDataObjectExists](lib/weaviate_api/objects/check_if_data_object_exists.ex)
- [WeaviateApi.Objects.UpdateDataObject](lib/weaviate_api/objects/update_data_object.ex)
- [WeaviateApi.Objects.DeleteDataObject](lib/weaviate_api/objects/delete_data_object.ex)
- [WeaviateApi.Objects.ValidateDataObject](lib/weaviate_api/objects/validate_data_object.ex)
- [WeaviateApi.Objects.AddCrossReference](lib/weaviate_api/objects/add_cross_reference.ex)
- [WeaviateApi.Objects.UpdateCrossReference](lib/weaviate_api/objects/update_cross_reference.ex)
- [WeaviateApi.Objects.DeleteCrossReference](lib/weaviate_api/objects/delete_cross_reference.ex)
- [WeaviateApi.Batch.BatchCreateObjects](lib/weaviate_api/batch/batch_create_objects.ex)
- [WeaviateApi.Batch.BatchCreateReferences](lib/weaviate_api/batch/batch_create_references.ex)
- [WeaviateApi.Batch.BatchDeleteObjects](lib/weaviate_api/batch/batch_delete_objects.ex)
- [WeaviateApi.Backups.CreateBackup](lib/weaviate_api/backups/create_backup.ex)
- [WeaviateApi.Backups.GetStatusOfBackup](lib/weaviate_api/backups/get_status_of_backup.ex)
- [WeaviateApi.Backups.RestoreBackup](lib/weaviate_api/backups/restore_backup.ex)
- [WeaviateApi.Backups.RestoreStatus](lib/weaviate_api/backups/restore_status.ex)
- [WeaviateApi.Classification.StartClassification](lib/weaviate_api/classification/start_classification.ex)
- [WeaviateApi.Classification.GetClassificationStatus](lib/weaviate_api/classification/get_classification_status.ex)
- [WeaviateApi.Meta.GetMetaInformation](lib/weaviate_api/meta/get_meta_information.ex)
- [WeaviateApi.Nodes.GetInformationAboutNodes](lib/weaviate_api/nodes/get_information_about_nodes.ex)
- [WeaviateApi.WellKnown.GetOpenIDConfiguration](lib/weaviate_api/well_known/get_openid_configuration.ex)
- [WeaviateApi.WellKnown.Liveness](lib/weaviate_api/well_known/liveness.ex)
- [WeaviateApi.WellKnown.Readiness](lib/weaviate_api/well_known/readiness.ex)

Each module corresponds to a specific functionality provided by the Weaviate API. You can use the functions in these modules to interact with the respective API endpoints.

Refer to the documentation for each module to learn about the available functions and their usage.

## Documentation

You can generate the documentation for this project using ExDoc. Run `mix docs` and open the `doc/index.html` file in your browser.

## Tests

To run the tests for this project, use the command `mix test`.

## Contributing

If you'd like to contribute to the development of the Weaviate Elixir API Wrapper, please submit a pull request with your changes or open an issue to discuss your proposed changes.

## License

The Weaviate Elixir API Wrapper is released under the [MIT License](https://opensource.org/licenses/MIT).
