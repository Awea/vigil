defmodule Vigil.Urls do
  @moduledoc """
  This module handle the operations done in Redis.
  """

  alias Exredis.Api, as: Repo

  @doc """
  Return a List of urls.
  """
  def all do
    urls_keys
    |> Enum.map(&Repo.get/1)
  end

  @doc """
  Remove urls.
  """
  def delete_all do
    urls_keys
    |> Enum.each(&Repo.del/1)
  end

  @doc """
  Store a new url.
  """
  def add(value) do
    Repo.set("url:#{value}", value)
  end

  defp urls_keys do
    Repo.keys("url:*")
  end
end