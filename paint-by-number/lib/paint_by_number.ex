defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    loop(0, color_count)
  end

  defp loop(e, target) do
    if Integer.pow(2, e) >= target, do: e, else: loop(e + 1, target)
  end

  def empty_picture(), do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    case picture do
       <<first::size(bit_size), _::bitstring>> -> first
       <<>> -> nil
    end
  end

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    case picture do
      <<_::size(bit_size), rest::bitstring>> -> rest
      <<>> -> <<>>
    end
  end

  def concat_pictures(picture1, picture2), do: <<picture1::bitstring, picture2::bitstring>>
end
