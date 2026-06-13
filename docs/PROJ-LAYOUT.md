# Project Layout

```
elixir-weaviate/
├── config/                         # Mix compile-time configuration
│   ├── config.exs                  #   Shared config (Finch pool, endpoint)
│   ├── dev.exs                     #   Dev overrides
│   └── test.exs                    #   Test overrides (Mimic)
├── docs/                           # Documentation
│   ├── layout/                     #   Detailed layout breakdowns
│   ├── graphql.md                  #   GraphQL API reference
│   ├── modules.md                  #   Vectorizer/generative module catalog
│   ├── rest-api.md                 #   REST API reference (v1.28+)
│   ├── PROJ-LAYOUT.md              #   This file
│   └── PROJ-LAYOUT.summary.md     #   Companion tree summary
├── lib/                            # Application source → [layout/lib.md](layout/lib.md)
│   ├── weaviate_api/               #   REST API wrappers (1:1 with endpoints)
│   ├── weaviate_classes/           #   `weaviate_class` macro and protocol
│   ├── weaviate_graph_ql/          #   GraphQL builder-pattern queries
│   ├── weaviate_structs/           #   Data type structs for Weaviate concepts
│   ├── application.ex              #   OTP Application (starts Finch pool)
│   └── noizu_weaviate.ex           #   Root module, `api_call/5` entry point
├── test/                           # Test suites
│   ├── api/                        #   Unit tests (mocked HTTP via Mimic)
│   ├── live/                       #   Integration tests (real Weaviate, `@moduletag :live`)
│   ├── support/                    #   Test helper modules and class definitions
│   └── test_helper.exs             #   Test setup (ExUnit, Mimic)
├── .formatter.exs                  # Elixir formatter config
├── .gitignore                      # Git ignore rules
├── .tool-versions                  # asdf — Elixir 1.20.1, Erlang 29.0.2
├── CLAUDE.md                       # Claude Code project instructions
├── docker-compose.yml              # Weaviate + modules on localhost:9004
├── LICENSE                         # MIT license
├── mix.exs                         # Project definition, deps, Hex metadata
├── mix.lock                        # Locked dependency versions
├── README.md                       # Project overview and usage
└── TODO.md                         # Outstanding work items
```

## Key Files Requiring Setup

| File | Action |
|------|--------|
| `.tool-versions` | Install Elixir/Erlang via `asdf install` |
| `docker-compose.yml` | Run `docker-compose up -d` for local Weaviate |
| `OPENAI_API_KEY` env | Set for generative-openai features |
