defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn i -> i[:price] end)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn i -> is_nil(i[:price]) end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn i ->
      Map.put(i, :name, String.replace(i[:name], old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    new_sizes = Map.new(item[:quantity_by_size], fn {k, v} -> {k, v + count} end)
    Map.put(item, :quantity_by_size, new_sizes)
  end

  def total_quantity(item),
    do: Enum.reduce(item[:quantity_by_size], 0, fn {_, v}, acc -> acc + v end)
end
