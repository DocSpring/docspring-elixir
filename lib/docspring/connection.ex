# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Connection do
  @moduledoc """
  Handle Tesla connections for Docspring.

  Additional middleware can be set in the compile-time or runtime configuration:

      config :tesla, Docspring.Connection,
        base_url: "https://sync.api.docspring.com/api/v1",
        adapter: Tesla.Adapter.Hackney

  The default base URL can also be set as:

      config :docspring,
        :base_url, "https://sync.api.docspring.com/api/v1"
  """

  @default_base_url Application.compile_env(
                      :docspring,
                      :base_url,
                      "https://sync.api.docspring.com/api/v1"
                    )


  @typedoc """
  The list of options that can be passed to new/1.

  - `base_url`: Overrides the base URL on a per-client basis.
  - `user_agent`: Overrides the User-Agent header.
  - `username`: A username for basic authentication.
  - `password`: A password for basic authentication.
  """
  @type options :: [
          {:base_url, String.t()},
          {:user_agent, String.t()},
          {:username, String.t() | nil},
          {:password, String.t() | nil},
        ]

  @doc "Forward requests to Tesla."
  @spec request(Tesla.Client.t(), [Tesla.option()]) :: Tesla.Env.result()
  defdelegate request(client, options), to: Tesla

  @doc """
  Configure a client with no authentication.

  ### Returns

  Tesla.Env.client
  """
  @spec new() :: Tesla.Env.client()
  def new do
    Tesla.client(middleware(), adapter())
  end

  @doc """
  Configure a client that may have authentication.

  ### Parameters

  - `options`: a keyword list of OpenAPIPetstore.Connection.options.

  ### Returns

  Tesla.Env.client
  """
  @spec new(options) :: Tesla.Env.client()

  def new(options) when is_list(options) do
    options
    |> middleware()
    |> Tesla.client(adapter())
  end

  @doc """
  Configure a client using username and password for basic authentication.

  ### Parameters

  - `username`: a String representing a username.
  - `password`: a String representing a password.
  - `options`: a keyword list of Docspring.Connection.options.

  ### Returns

  Tesla.Env.client
  """
  @spec new(String.t(), String.t(), options) :: Tesla.Env.client()


  def new(username, password, options) when is_binary(username) and is_binary(password) do
    options
    |> Keyword.merge(username: username, password: password)
    |> new()
  end

  @doc """
  Returns fully configured middleware for passing to Tesla.client/2.
  """
  @spec middleware(options) :: [Tesla.Client.middleware()]
  def middleware(options \\ []) do
    base_url =
      Keyword.get(
        options,
        :base_url,
        Application.get_env(:docspring, :base_url, @default_base_url)
      )

    tesla_options = Application.get_env(:tesla, __MODULE__, [])
    middleware = Keyword.get(tesla_options, :middleware, [])
    json_engine = Keyword.get(tesla_options, :json, Jason)

    user_agent =
      Keyword.get(
        options,
        :user_agent,
        Keyword.get(
          tesla_options,
          :user_agent,
          "docspring-elixir-2.1.0"
        )
      )

    username = Keyword.get(options, :username)
    password = Keyword.get(options, :password)
    middleware =
      if username || password do
        [{Tesla.Middleware.BasicAuth, %{username: username, password: password}} | middleware]
      else
        middleware
      end


    [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.Headers, [{"user-agent", user_agent}]},
      {Tesla.Middleware.EncodeJson, engine: json_engine}
      | middleware
    ]
  end


  @doc """
  Returns the default adapter for this API.
  """
  def adapter do
    :tesla
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:adapter, nil)
  end
end
