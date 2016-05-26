defmodule Mix.Tasks.Vigil.FeedProcess do
  use Mix.Task

  @shortdoc "Fetch news urls from github feed and store them"
  def run(_) do
    {:ok, _started} = Application.ensure_all_started(:vigil)

    Vigil.FeedStore.process_feed
  end
end