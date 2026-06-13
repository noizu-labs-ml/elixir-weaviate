
import Config

config :junit_formatter,
       report_file: "results.xml"

config :noizu_weaviate,
       endpoint: System.get_env("WEAVIATE_ENDPOINT", "http://localhost:9004/"),
       weaviate_api_key: System.get_env("WEAVIATE_API_KEY")
