# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :exredis,
  host: "127.0.0.1",
  port: 6379,
  password: "",
  db: 0,
  reconnect: :no_reconnect,
  max_queue: :infinity

config :quantum, cron: [
  feed_process: [
    schedule: "@hourly",
    task: "Vigil.FeedStore.process_feed"
  ],
  feed_report: [
    schedule: "30 6 * * *", # UTC timezone in Quantum doesn't work.
    task: "Vigil.FeedReport.send_and_clean"
  ]
]

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
import_config "secret.exs"