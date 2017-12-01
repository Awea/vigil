defmodule Vigil.FeedReport do
  import Bamboo.Email

  alias Vigil.RedisApi

  def send_and_clean do
    send
    RedisApi.flush_urls
  end

  def send do
    RedisApi.get_urls |> email
  end

  defp email([]), do: IO.puts("no urls")

  defp email(urls) do
    new_email(
      to: "david@wearemd.com",
      from: "bot@wearemd.com",
      subject: "Github feed",
      html_body: mail_template(urls)
    )
    |> Vigil.Mailer.deliver_now
  end

  defp mail_template(urls) do
    File.read!("templates/feed_report.html.slim") |> Slime.render(urls: urls)
  end
end