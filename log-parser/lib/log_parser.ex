defmodule LogParser do
  def valid_line?(line) do
    Regex.match?(~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/, line)
  end

  def split_line(line) do
    Regex.split(~r/<[~*=~-]*>/, line)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    Regex.replace(~r/(.*)(User\s+)(\S+)(.*)/, line, fn _, _, user, _ -> "[USER] #{user} #{line}" end)
  end
end
