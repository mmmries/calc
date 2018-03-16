defmodule Calc.TokenizingTest do
  use ExUnit.Case, async: true

  test "tokenizing basic numbers" do
    str = """
    15
    17
    15.713
    0.12
    1.1e3
    """ |> String.to_charlist

    assert {:ok, tokens, _} =  :calc_tokenizer.string(str)
    assert tokens == [
      {:int, 15, 1},
      {:int, 17, 2},
      {:float, 15.713, 3},
      {:float, 0.12, 4},
      {:float, 1100.0, 5},
    ]
  end

  test "tokenizing operators" do
    str = '+ - / * == > >= <= <'
    assert {:ok, tokens, _} = :calc_tokenizer.string(str)
    assert tokens == [
      {:+, 1},
      {:-, 1},
      {:/, 1},
      {:*, 1},
      {:==, 1},
      {:>, 1},
      {:>=, 1},
      {:<=, 1},
      {:<, 1},
    ]
  end

  test "tokenizing parenthesized statements" do
    str = '(14 + 10) * 8'
    assert {:ok, tokens, _} = :calc_tokenizer.string(str)
    assert tokens == [
      {:"(", 1},
      {:int, 14, 1},
      {:+, 1},
      {:int, 10, 1},
      {:")", 1},
      {:*, 1},
      {:int, 8, 1},
    ]
  end
end
