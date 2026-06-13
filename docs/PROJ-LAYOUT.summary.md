# Project Layout Summary

```
elixir-weaviate/
├── config/                         # Mix configuration
├── docs/                           # Documentation and references
│   └── layout/                     #   Detailed layout breakdowns
├── lib/                            # Application source
│   ├── weaviate_api/               #   REST API wrappers
│   ├── weaviate_classes/           #   Class macro system
│   ├── weaviate_graph_ql/          #   GraphQL query builders
│   ├── weaviate_structs/           #   Weaviate data type structs
│   ├── application.ex              #   OTP Application
│   └── noizu_weaviate.ex           #   Root module
├── test/                           # Test suites
│   ├── api/                        #   Unit tests (mocked)
│   ├── live/                       #   Integration tests
│   └── support/                    #   Test helpers
├── .tool-versions                  # asdf versions
├── docker-compose.yml              # Local Weaviate
├── mix.exs                         # Project definition
└── README.md                       # Start here
```
