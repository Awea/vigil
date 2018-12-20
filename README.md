# Vigil

"Simple" feed parser/reporter

## Configuration

### Get api_token_feed

![get-api-token-feed](github-atom-key.gif)

### config/secret.exs

```elixir
use Mix.Config

config :vigil,
  github: %{
    username: "username",
    token: "api_token_feed"
  },
  twitter: %{
    searches: ["search one", "search two"],
    filters: %{
      screen_names: ["nameOne", "nameTwo"],
      words: ["word1", "word2"]
    }
  }

config :vigil, Vigil.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp_server",
  hostname: "domain_name",
  port: port,
  username: "smtp_username",
  password: "smtp_password",
  ssl: true,
  tls: :if_available,
  retries: 1

#  Get from https://apps.twitter.com/app
config :extwitter, :oauth, [
   consumer_key: "consumer_key",
   consumer_secret: "consumer_secret",
   access_token: "access_token",
   access_token_secret: "access_token_secret"
]
```

## Release
### Setup
Update your `~/.ssh/config` with:

```
Host localhost
  Port 2222
```

Copy your `~/.ssh/id_rsa.pub` to `config/id_rsa.pub`.

### Usage
`make upgrade_production`
