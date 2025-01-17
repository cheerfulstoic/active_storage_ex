# ExActiveStorage (WIP)

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_active_storage` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_active_storage, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_active_storage](https://hexdocs.pm/ex_active_storage).

## configuration:

### config:

```elixir


config :ex_aws,
  debug_requests: true,
  # access_key_id: {:system, "AWS_ACCESS_KEY_ID"},
  # security_token: {:system, "AWS_SESSION_TOKEN"},
  # secret_access_key: {:system, "AWS_SECRET_ACCESS_KEY"},
  # region: {:system, "AWS_S3_REGION"}
  region: System.get_env("AWS_S3_REGION"),
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY")


config :my_app, :storage,
  service: "amazon",
  amazon: %{
    service: "S3",
    region: System.get_env("AWS_S3_REGION"),
    access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
    secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY")
  },
  local: %{service: "Disk", root: "storage"},
  test: %{
    service: "Disk",
    root: "tmp/storage"
  }
```

### router:

```elixir
  scope "/", MyAppWeb do
    pipe_through :browser

    get "/active_storage/blobs/redirect/:signed_id", ActiveStorageController, :show
```

## direct upload

### Absinthe:

```elixir
mutation do
  field :create_direct_upload, :direct_upload_response do
    arg(:input, non_null(:direct_upload))
    resolve(&ActiveStorage.graphql_resolver/3)
  end
end
```

### usage blob

```elixir
  {:ok, file} = File.read("./uploads/github-social.png")
  filename = "github-social.png"
  {mime, w, h, _kind} = ExImageInfo.info(file)
  blob = %ActiveStorage.Blob{}

      r =
        ActiveStorage.Blob.create_and_upload!(blob, %{
          io: file,
          filename: filename,
          content_type: mime,
          metadata: nil,
          service_name: "amazon",
          identify: true
        })

      ActiveStorage.url(r) # direct url temporal to aws
      ActiveStorage.service_url(r) # redirect url

      a = ActiveStorage.Blob.Representable.variant(r, %{resize_to_limit: "100x100"}) |> ActiveStorage.Variant.processed()
```
