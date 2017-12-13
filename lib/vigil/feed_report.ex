defmodule Vigil.FeedReport do
  @moduledoc """
  This module get urls from Redis and send them in an email.
  """

  import Bamboo.Email

  require Slime
  require Logger

  alias Vigil.Urls

  # Compile template into a function, see: https://hexdocs.pm/slime/Slime.html#function_from_file/5
  Slime.function_from_file :def, :mail_template, "templates/feed_report.slime", [:urls]

  @doc """
  Send the urls and remove them from Redis.
  """
  def send_and_clean do
    send
    Urls.delete_all
  end

  @doc """
  Send the urls.
  """
  def send do
    Urls.all |> email
  end

  # Emails aren't delivered through OVH SMTP if text_body is missing
  # since 13/12/2017.
  defp email([]), do: Logger.info "no urls"
  defp email(urls) do
    new_email(
      to: "david@wearemd.com",
      from: "bot@wearemd.com",
      subject: "Github feed",
      html_body: mail_template(urls),
      text_body: "see this in html"
    )
    |> Vigil.Mailer.deliver_now
  end
end