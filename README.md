# Noizu.Weaviate

Noizu.Weaviate is a library providing a simple wrapper around Weaviate's API calls. It handles various API features such as meta information, batch operations, backups, schema operations, nodes information, data objects, and classification.

## Installation

To install Noizu.Weaviate, add the following to your `mix.exs` file:

```elixir
defp deps do
  [
    {:noizu_weaviate, "~> 0.1.0"}
  ]
end
```

Then, run `mix deps.get` to fetch the dependencies.

## Configuration

To configure the library, you need to set the Weaviate API key in your application's configuration:

```elixir
config :noizu_weaviate,
  weaviate_api_key: "your_api_key_here"
```

Replace `"your_api_key_here"` with your actual Weaviate API key.

## Usage

Noizu.Weaviate provides modules for different Weaviate API endpoints:

- [Noizu.Weaviate.Api.Meta](weaviate_api/meta/README.md)
- [Noizu.Weaviate.Api.Batch](weaviate_api/batch/README.md)
- [Noizu.Weaviate.Api.Backups](weaviate_api/backups/README.md)
- [Noizu.Weaviate.Api.Schema](weaviate_api/schema/README.md)
- [Noizu.Weaviate.Api.Nodes](weaviate_api/nodes/README.md)
- [Noizu.Weaviate.Api.Objects](weaviate_api/objects/README.md)
- [Noizu.Weaviate.Api.Auth](weaviate_api/auth/README.md)
- [Noizu.Weaviate.Api.Classification](weaviate_api/classification/README.md)

Each module corresponds to a specific functionality provided by the Weaviate API. You can use the functions in these modules to interact with the respective API endpoints.

Here's an example of using the `Noizu.Weaviate.Api.Meta` module to get meta information about the Weaviate instance:

```elixir
alias Noizu.Weaviate.Api.Meta

{:ok, response} = Meta.get_meta_information()
```

Refer to the documentation for each module to learn about the available functions and their usage.

## Documentation

You can generate the documentation for this project using ExDoc. Run `mix docs` and open the `doc/index.html` file in your browser.

## Tests

To run the tests for this project, use the command `mix test`.

## Contributing

If you'd like to contribute to the development of Noizu.Weaviate, please submit a pull request with your changes or open an issue to discuss your proposed changes.

## License

Noizu.Weaviate is released under the [MIT License](https://opensource.org/licenses/MIT).
