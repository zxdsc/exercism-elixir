defmodule RPG do
  alias RPG.Edible
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(item, %Character{health: hp} = character) do
      {nil, %{character | health: hp + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: str}, %Character{mana: mp} = char) do
      {%EmptyBottle{}, %{char | mana: mp + str}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_, %Character{health: _} = char) do
      {%EmptyBottle{}, %{char | health: 0}}
    end
  end

end
