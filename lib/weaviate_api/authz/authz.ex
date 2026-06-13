defmodule Noizu.Weaviate.Api.Authz do
  @moduledoc """
  Functions for interacting with the Weaviate RBAC authorization API.
  """

  require Noizu.Weaviate
  import Noizu.Weaviate

  # -------------------------------
  # Roles
  # -------------------------------

  @doc """
  List all roles.

  ## Returns

  A tuple `{:ok, response}` on successful API call, where `response` is the API response.
  Returns `{:error, term}` on failure, where `term` contains error details.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.list_roles()
  """
  @spec list_roles(options :: any) :: {:ok, any()} | {:error, any()}
  def list_roles(options \\ nil) do
    url = api_base() <> "v1/authz/roles"
    api_call(:get, url, nil, :json, options)
  end

  @doc """
  Create a new role.

  ## Parameters

  - `role` (required) - A map with role name and permissions.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.create_role(%{name: "editor", permissions: [...]})
  """
  @spec create_role(map(), options :: any) :: {:ok, any()} | {:error, any()}
  def create_role(role, options \\ nil) do
    url = api_base() <> "v1/authz/roles"
    api_call(:post, url, role, :json, options)
  end

  @doc """
  Get a role by name.

  ## Parameters

  - `role_name` (required) - The name of the role.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.get_role("editor")
  """
  @spec get_role(String.t(), options :: any) :: {:ok, any()} | {:error, any()}
  def get_role(role_name, options \\ nil) do
    url = api_base() <> "v1/authz/roles/#{role_name}"
    api_call(:get, url, nil, :json, options)
  end

  @doc """
  Delete a role by name.

  ## Parameters

  - `role_name` (required) - The name of the role.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.delete_role("editor")
  """
  @spec delete_role(String.t(), options :: any) :: {:ok, any()} | {:error, any()}
  def delete_role(role_name, options \\ nil) do
    url = api_base() <> "v1/authz/roles/#{role_name}"
    api_call(:delete, url, nil, :json, options)
  end

  @doc """
  Add permissions to a role.

  ## Parameters

  - `role_name` (required) - The name of the role.
  - `permissions` (required) - A list of permissions to add.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.add_permissions("editor", [%{action: "read", collection: "*"}])
  """
  @spec add_permissions(String.t(), list(), options :: any) :: {:ok, any()} | {:error, any()}
  def add_permissions(role_name, permissions, options \\ nil) do
    url = api_base() <> "v1/authz/roles/#{role_name}/add-permissions"
    body = %{permissions: permissions}
    api_call(:post, url, body, :json, options)
  end

  @doc """
  Remove permissions from a role.

  ## Parameters

  - `role_name` (required) - The name of the role.
  - `permissions` (required) - A list of permissions to remove.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.remove_permissions("editor", [%{action: "read", collection: "*"}])
  """
  @spec remove_permissions(String.t(), list(), options :: any) :: {:ok, any()} | {:error, any()}
  def remove_permissions(role_name, permissions, options \\ nil) do
    url = api_base() <> "v1/authz/roles/#{role_name}/remove-permissions"
    body = %{permissions: permissions}
    api_call(:post, url, body, :json, options)
  end

  @doc """
  Get users assigned to a role.

  ## Parameters

  - `role_name` (required) - The name of the role.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.get_role_users("editor")
  """
  @spec get_role_users(String.t(), options :: any) :: {:ok, any()} | {:error, any()}
  def get_role_users(role_name, options \\ nil) do
    url = api_base() <> "v1/authz/roles/#{role_name}/users"
    api_call(:get, url, nil, :json, options)
  end

  # -------------------------------
  # User Role Assignment
  # -------------------------------

  @doc """
  Assign roles to a user.

  ## Parameters

  - `user_id` (required) - The ID of the user.
  - `roles` (required) - A list of role names to assign.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.assign_roles("user123", ["editor", "viewer"])
  """
  @spec assign_roles(String.t(), list(), options :: any) :: {:ok, any()} | {:error, any()}
  def assign_roles(user_id, roles, options \\ nil) do
    url = api_base() <> "v1/authz/users/#{user_id}/assign"
    body = %{roles: roles}
    api_call(:post, url, body, :json, options)
  end

  @doc """
  Revoke roles from a user.

  ## Parameters

  - `user_id` (required) - The ID of the user.
  - `roles` (required) - A list of role names to revoke.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.revoke_roles("user123", ["editor"])
  """
  @spec revoke_roles(String.t(), list(), options :: any) :: {:ok, any()} | {:error, any()}
  def revoke_roles(user_id, roles, options \\ nil) do
    url = api_base() <> "v1/authz/users/#{user_id}/revoke"
    body = %{roles: roles}
    api_call(:post, url, body, :json, options)
  end

  @doc """
  Get roles assigned to a user.

  ## Parameters

  - `user_id` (required) - The ID of the user.
  - `options` (optional) - Additional options for the API call.

  ## Examples

      {:ok, response} = Noizu.Weaviate.Api.Authz.get_user_roles("user123")
  """
  @spec get_user_roles(String.t(), options :: any) :: {:ok, any()} | {:error, any()}
  def get_user_roles(user_id, options \\ nil) do
    url = api_base() <> "v1/authz/users/#{user_id}/roles"
    api_call(:get, url, nil, :json, options)
  end
end
