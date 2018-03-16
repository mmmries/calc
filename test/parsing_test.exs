defmodule Calc.ParsingTest do
  use ExUnit.Case, async: true

  test "parsing operators" do
    tokens = [
      {:"(", 1},
      {:int, 14, 1},
      {:+, 1},
      {:int, 10, 1},
      {:")", 1},
      {:*, 1},
      {:int, 8, 1},
    ]

    assert {:ok, ast} = :calc_parser.parse(tokens)
    assert {:*, _, [
      {:+, _, [14, 10]},
      8
    ]} = ast
  end
end
