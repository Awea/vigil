# Vigil

"Simple" feed parser/reporter

## Configuration

```elixir
# config/secret.exs

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