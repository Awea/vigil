# Vigil

"Simple" feed parser/reporter

## Configuration

### config/secret.exs

```elixir
use Mix.Config

config :vigil,
  github: %{
    username: "username",
    token: "api_token_feed"
  }

config :mailman,
  relay: "smtp_server",
  port: port_used,
  username: "smtp_username",
  password: "smtp_password",
  ssl: true
```

### config/config.exs

* [:quantum](https://github.com/c-rack/quantum-elixir)

## Release

* `mix release`

### Debian

* Required GLIC_2.15, see [this](http://stackoverflow.com/questions/10863613/how-to-upgrade-glibc-from-version-2-13-to-2-15-on-debian)

