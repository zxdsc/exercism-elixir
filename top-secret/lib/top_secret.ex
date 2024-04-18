defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted(string) |> elem(1)

  def decode_secret_message_part(ast, acc) do
    to_add = case ast do
      {tok, _, func} when tok in [:def, :defp] ->
        case func do
          [{:when, _, [{func_name, _, params} | _]} | _] -> Atom.to_string(func_name) |> String.slice(0, length(params))
          [{_, _, nil} | _] -> ""
          [{func_name, _, params} | _] -> Atom.to_string(func_name) |> String.slice(0, length(params))
          _ -> nil
        end
      _ -> nil
    end
    if to_add, do: {ast, [to_add | acc]}, else: {ast, acc}
  end

  def decode_secret_message(string) do
    to_ast(string)
      |> Macro.prewalk([], fn e, acc -> decode_secret_message_part(e, acc) end)
      |> elem(1)
      |> Enum.reverse()
      |> Enum.reduce(fn e, acc -> acc <> e end)
  end
end
