defmodule Vigil.RedisApi do
  alias Exredis.Api, as: Repo

  def get_urls do
    urls_keys
    |> Enum.map(&Repo.get/1)
  end

  def flush_urls do
    urls_keys
    |> Enum.each(&Repo.del/1)
  end

  def store(value) do
    Repo.set("url:#{value}", value)
  end

  defp urls_keys do
    Repo.keys("url:*")
  end
end