defmodule Vigil.TwitterSearch do
  @moduledoc """
  This module do research on twitter, store and report them. To made this module operational, the following configuration is required:

  ```
  config :vigil,
  twitter: %{
    searches: ["search one", "search two"],
    filters: %{
      screen_names: ["nameOne", "nameTwo"],
      words: ["word1", "word2"]
    }
  }
  ```
  """

  import Bamboo.Email

  require Slime
  require Logger

  alias Vigil.Tweets

  # Compile template into a function, see: https://hexdocs.pm/slime/Slime.html#function_from_file/5
  Slime.function_from_file :def, :mail_template, "templates/twitter_report.slime", [:tweets]

  @doc """
  Search, filter and store tweets.
  """
  def search do
    searches
    |> Enum.map(&ExTwitter.search/1)
    |> Enum.concat()
    |> Enum.filter(&filter_screen_names/1)
    |> Enum.filter(&filter_text/1)
    |> Enum.map(&format_tweet/1)
    |> Enum.each(&Tweets.add/1)
  end

  @doc """
  Repot tweets.
  """
  def report do
    Tweets.all
    |> email

    Tweets.delete_all
  end

  defp email([]), do: Logger.info "no tweets"
  defp email(tweets) do
    new_email(
      to: "david@wearemd.com",
      from: "bot@wearemd.com",
      subject: "Twitter feed",
      html_body: mail_template(tweets)
    )
    |> Vigil.Mailer.deliver_now
  end

  # %{id: id, user: @user, text: text, url: link_to_tweet}
  defp format_tweet(tweet) do
    %{
      id: tweet.id_str,
      user: tweet.user.screen_name,
      text: tweet.text,
      url: "https://twitter.com/i/web/status/#{tweet.id_str}"
    }
  end

  defp filter_screen_names(tweet) do
    !Enum.member?(filter_value(:screen_names), tweet.user.screen_name)
  end

  defp filter_text(tweet) do
    !String.contains?(tweet.text, filter_value(:words))
  end

  defp filter_value(filter_name) do
    configutation()
    |> Map.get(:filters)
    |> Map.get(filter_name)
  end

  defp searches do
    configutation()
    |> Map.get(:searches)
  end

  defp configutation do
    Application.get_env(:vigil, :twitter) 
  end
end