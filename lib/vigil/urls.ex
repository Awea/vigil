defmodule Vigil.Urls do

  alias Exredis.Api, as: Repo

  def all do
    urls_keys
    |> Enum.map(&Repo.get/1)
  end

  def delete_all do
    urls_keys
    |> Enum.each(&Repo.del/1)
  end

  def add(value) do
    Repo.set("url:#{value}", value)
  end

  defp urls_keys do
    Repo.keys("url:*")
  end
end