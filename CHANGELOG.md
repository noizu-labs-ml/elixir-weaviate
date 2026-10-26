# Changelog

Dated work log — newest first. One line per landed change.

## 2026-10-26

- docs: doc-sweep 2026-10-26 — layout (.github/ added to trees), schema (endpoint/api-key source corrections: test.exs reads WEAVIATE_ENDPOINT, dev hardcoded; api key read per-request via headers/0), threat model (T-003 Logger.warn → Logger.warning per Elixir 1.20 source); no arch changes needed.
