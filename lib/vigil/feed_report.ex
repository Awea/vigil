defmodule Vigil.FeedReport do
  alias Vigil.RedisApi

  def send do
    RedisApi.get_urls |> email
  end

  defp email([]), do: IO.puts("no urls")

  defp email(urls) do
    deliver %Mailman.Email{
      subject: "Github feed",
      from: "bot@wearemd.com",
      to: ["david@wearemd.com"],
      html: mail_template(urls)
    }
  end

  defp mail_template(urls) do
    File.read!("templates/feed_report.html.slim") |> Slime.render(urls: urls)
  end

  defp deliver(email) do
    Mailman.deliver(email, config)
  end

  def config do
    %Mailman.Context{}
  end
end