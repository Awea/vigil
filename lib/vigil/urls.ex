defmodule Vigil.Urls do
  @moduledoc """
  This module handle the operations done in Redis.
  """

  alias Exredis.Api, as: Repo

  require Logger

  @doc """
  Return a List of urls.
  """
  def all do
    urls_keys
    |> Enum.map(&Repo.get/1)
  end

  @doc """
  Remove urls and store removed to url-sent.
  """
  def delete_all do
    all 
    |> Enum.map(&Repo.set("url-sent:#{&1}", &1))

    urls_keys
    |> Enum.each(&Repo.del/1)
  end

  @doc """
  Store a new url if doesn't exist in url-sent:*.
  """
  def add(value) do
    case Repo.get("url-sent:#{value}") do
      :undefined -> Repo.set("url:#{value}", value)
      _          -> Logger.info "url already sent"
    end
  end

  defp urls_keys do
    Repo.keys("url:*")
  end
end