defmodule Newsletter do
  alias ElixirSense.Core.Bitstring

  def read_emails(path) do
    File.read(path)
    |> elem(1)
    |> String.split("\n")
    |> Enum.filter(fn e -> e != "" end)
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.write(pid, email <> "\n")

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    log_file = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email ->
      r = send_fun.(email)
      if r == :ok, do: log_sent_email(log_file, email)
    end)

    close_log(log_file)
  end
end
