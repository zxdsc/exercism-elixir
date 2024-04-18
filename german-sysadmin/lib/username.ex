defmodule Username do
  def sanitize([]), do: []

  def sanitize([h | t]) do
    cleaned =
      case h do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        x when x >= ?a and x <= ?z -> [x]
        ?_ -> ~c"_"
        _ -> ~c""
      end

    cleaned ++ sanitize(t)
  end

  def sanitize([h | t]), do: sanitize(t)
end
