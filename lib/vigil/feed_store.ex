defmodule Vigil.FeedStore do
  alias Vigil.Urls

  def process_feed do
    get_feed |> FeederEx.parse |> filter_feed |> Enum.each(&(Urls.add/1))
  end

  defp get_feed do
    response = HTTPotion.get github_feed

    response.body
  end

  defp filter_feed({:ok, feed, _}) do
    feed.entries |> Enum.filter(fn(entry) ->
      String.contains?(entry.id, "WatchEvent") && !String.contains?(entry.link, ["wearemd", "awea", "mmaayylliiss"])
    end) |> Enum.map(fn(entry) ->
      entry.link
    end)
  end

  defp github_feed do
    "https://github.com/#{github_config(:username)}.private.atom?token=#{github_config(:token)}"
  end

  defp github_config(key) do
    Application.get_env(:vigil, :github) |> Map.get(key)
  end
end