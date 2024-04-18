defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path_array = String.split(path, ".")
    extract(data, path_array)
  end

  defp extract(data, []), do: data
  defp extract(data, [h | tail]), do: extract(data[h], tail)

  def get_in_path(data, path), do: Kernel.get_in(data, String.split(path, "."))
end
