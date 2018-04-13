defmodule ElixirBasics.Models.Flashcard do
  @derive [Poison.Encoder]
  defstruct version: 1, front: "", back: ""
end
