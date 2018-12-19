defmodule Vigil.FeedStore do
  @moduledoc """
  This module get an XML feed from GitHub, filter it, extract urls, then store them in Redis.
  """

  import Bamboo.Email

  alias Vigil.Urls

  def process_feed do
    github_feed()
    |> HTTPotion.get
    |> get_parsed_response
    |> filter_feed 
    |> format_feed
    |> Enum.each(&(Urls.add/1))
  end

  defp get_parsed_response(%{status_code: 401}) do
    new_email(
      to: "david@wearemd.com",
      from: "bot@wearemd.com",
      subject: "Github feed error",
      html_body: "<p>Please update github.token in config/secrets.exs</p>",
      text_body: "see this in html"
    )
    |> Vigil.Mailer.deliver_now

    :error
  end
  defp get_parsed_response(%{body: body, status_code: 200}), do: FeederEx.parse(body)

  # Filter the feed by removing WatchEvent and some users:
  # wearemd, awea, mmaayylliiss
  defp filter_feed({:ok, feed, _}) do
    feed.entries |> Enum.filter(fn(entry) ->
      String.contains?(entry.id, "WatchEvent") && !String.contains?(entry.link, ["wearemd", "awea", "mmaayylliiss"])
    end)
  end
  defp filter_feed(_), do: :error

  # Format feed to a List of Urls
  defp format_feed(:error), do: []
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