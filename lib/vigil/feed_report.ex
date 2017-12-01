defmodule Vigil.FeedReport do
  import Bamboo.Email

  require Slime
  require Logger

  alias Vigil.Urls

  # Compile template into a function, see: https://hexdocs.pm/slime/Slime.html#function_from_file/5
  Slime.function_from_file :def, :mail_template, "templates/feed_report.slime", [:urls]

  def send_and_clean do
    send
    Urls.delete_all
  end

  def send do
    Urls.all |> email
  end

  defp email([]), do: Logger.info "no urls"
  defp email(urls) do
    new_email(
      to: "david@wearemd.com",
      from: "bot@wearemd.com",
      subject: "Github feed",
      html_body: mail_template(urls)
    )
    |> Vigil.Mailer.deliver_now
  end
end