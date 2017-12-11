defmodule Vigil.FeedStore do
  @moduledoc """
  This module get an XML feed from GitHub, filter it, extract urls, then store them in Redis.
  """

  alias Vigil.Urls

  def process_feed do
    github_feed()
    |> HTTPotion.get
    |> Map.get(:body)
    |> FeederEx.parse 
    |> filter_feed 
    |> format_feed
    |> Enum.each(&(Urls.add/1))
  end

  # Filter the feed by removing WatchEvent and some users:
  # wearemd, awea, mmaayylliiss
  defp filter_feed({:ok, feed, _}) do
    feed.entries |> Enum.filter(fn(entry) ->
      String.contains?(entry.id, "WatchEvent") && !String.contains?(entry.link, ["wearemd", "awea", "mmaayylliiss"])
    end)
  end

  # Format feed to a List of Urls
  defp format_feed(entries) do
    Enum.map(entries, &(&1.link))
  end

  defp github_feed do
    "https://github.com/#{github_config(:username)}.private.atom?token=#{github_config(:token)}"
  end

  defp github_config(key) do
    Application.get_env(:vigil, :github) |> Map.get(key)
  end
end