defmodule Mix.Tasks.Vigil.FeedReport do
  use Mix.Task

  @shortdoc "Send all stored urls"
  def run(_) do
    {:ok, _started} = Application.ensure_all_started(:vigil)

    Vigil.FeedReport.send
    Vigil.RedisApi.flush_urls
  end
end