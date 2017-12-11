defmodule Vigil.Tweets do
  @moduledoc """
  This module handle the operations done in Redis.
  """

  alias Exredis.Api, as: Repo

  require Logger

  @doc """
  Return a List of tweets.
  """
  def all do
    tweets_keys
    |> Enum.map(&Repo.get/1)
    |> Enum.map(&Poison.decode!(&1, keys: :atoms!))
  end

  @doc """
  Remove tweet and store removed to tweet-sent.
  """
  def delete_all do
    all 
    |> Enum.map(&Repo.set("tweet-sent:#{&1.id}", &1.id))

    tweets_keys
    |> Enum.each(&Repo.del/1)
  end

  @doc """
  Store a new tweet if doesn't exist in tweet-sent:*.
  """
  def add(tweet) do
    case Repo.get("tweet-sent:#{tweet.id}") do
      :undefined -> Repo.set("tweet:#{tweet.id}", Poison.encode!(tweet))
      _          -> Logger.info "tweet already sent"
    end
  end

  defp tweets_keys do
    Repo.keys("tweet:*")
  end
end