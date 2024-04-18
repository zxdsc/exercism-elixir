defmodule DNA do
  alias ElixirSense.Core.Bitstring

  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      ?\s -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], acc), do: acc

  defp do_encode([head | tail], acc) do
    encode = encode_nucleotide(head)
    do_encode(tail, <<acc::bitstring, encode::size(4)>>)
  end

  def decode(dna), do: do_decode(dna, ~C"")

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<h::4, rest::bits>>, acc) do
    decoded = decode_nucleotide(h)
    do_decode(rest, acc ++ [decoded])
  end
end
