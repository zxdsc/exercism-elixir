defmodule Chessboard do
  def rank_range, do: 1..8

  def file_range do
    <<a::utf8>> = "A"
    <<h::utf8>> = "H"
    a..h
  end

  def ranks, do: rank_range() |> Enum.to_list()

  def files, do: file_range() |> Enum.map(fn e -> <<e>> end)
end
