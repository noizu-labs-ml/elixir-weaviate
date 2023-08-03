# Noizu.WeaviateApi.Auth

`Noizu.WeaviateApi.Auth` is a module that provides authentication functions for the Weaviate API. This module enables you to make API calls to the Weaviate endpoints with the specified HTTP method and URL. It also includes functions to retrieve the OpenID configuration, and check the liveness and readiness of the Weaviate application.

## API Call Function

Use the `api_call/2` function to make an API call to a Weaviate endpoint with the given HTTP method and URL.

### Parameters

- `method` (atom): The HTTP method for the API call, e.g. `:get`, `:post`, `:put`, `:delete`.
- `url` (string): The URL endpoint for the API call.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Examples

```elixir
{:ok, response} = Noizu.WeaviateApi.Auth.api_call(:get, "/v1/.well-known/openid-configuration")
```

## OpenID Configuration Function

Use the `get_openid_configuration/0` function to retrieve the OpenID configuration in Weaviate.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Examples

```elixir
{:ok, response} = Noizu.WeaviateApi.Auth.get_openid_configuration()
```

## Liveness Function

Use the `check_liveness/0` function to check if the Weaviate application is alive.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Examples

```elixir
{:ok, response} = Noizu.WeaviateApi.Auth.check_liveness()
```

## Readiness Function

Use the `check_readiness/0` function to check if the Weaviate application is ready to receive traffic.

### Returns

A tuple `{:ok, response}` on successful API call, where `response` is the API response.
Returns `{:error, term}` on failure, where `term` contains error details.

### Examples

```elixir
{:ok, response} = Noizu.WeaviateApi.Auth.check_readiness()
```

For more details on the `Noizu.WeaviateApi.Auth` module and its functions, refer to the source code and documentation.

Weaviate API Documentation
==========================

The Weaviate API provides a set of endpoints that allow you to interact with the Weaviate application.

OpenID Configuration
--------------------

The OpenID Configuration endpoint provides information about the OpenID Connect (OIDC) authentication settings in Weaviate. It redirects to the token issued if OIDC authentication is configured.

### Usage

Send a GET request to the following URL:

```
GET /v1/.well-known/openid-configuration
```

The endpoint returns the following fields:

- `href`: The reference to the client.
- `clientID`: The ID of the client.

If OIDC provider is not present, a 404 code will be returned.

### Example

Send a GET request to `http://localhost:8080/v1/.well-known/openid-configuration`:

```
$ curl http://localhost:8080/v1/.well-known/openid-configuration
```

The response should be:

```json
{
  "href": "http://my-token-issuer/auth/realms/my-weaviate-usecase",
  "clientID": "my-weaviate-client"
}
```

Liveness
--------

The Liveness endpoint determines whether the Weaviate application is alive. It can be used for Kubernetes liveness probe.

### Usage

Send a GET request to the following URL:

```
GET /v1/.well-known/live
```

It returns a 200 response if the application is able to respond to HTTP requests.

### Example

Send a GET request to `http://localhost:8080/v1/.well-known/live`:

```
$ curl http://localhost:8080/v1/.well-known/live
```

If the application is able to respond to HTTP requests, it should return a 200 response.

Readiness
---------

The Readiness endpoint determines whether the Weaviate application is ready to receive traffic. It can be used for Kubernetes readiness probe.

### Usage

Send a GET request to the following URL:

```
GET /v1/.well-known/ready
```

It returns a 200 response if the application is able to respond to HTTP requests and a 503 response if the application is currently not able to serve traffic. If there are other horizontal replicas of Weaviate available and they are capable of receiving traffic, all traffic should be redirected there instead.

### Example

Send a GET request to `http://localhost:8080/v1/.well-known/ready`:

```
$ curl http://localhost:8080/v1/.well-known/ready
```

If the application is able to respond to HTTP requests, it should return a 200 response.

For more details on the Weaviate API endpoints, please refer to the Weaviate API documentation.
