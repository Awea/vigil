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

