defmodule Calc.CompileTest do
  use ExUnit.Case, async: true

  test "you can execute an expression with hardcoded values" do
    Calc.compile("(14 + 10) * 8 > 10000", Calc.Hardcoded)
    assert Calc.Hardcoded.run(%{}) == false
  end

  test "you can execute an expression with variables" do
    Calc.compile("(14 + a) * b",Calc.WithVars)
    assert Calc.WithVars.run(%{a: 10, b: 8}) == 192
  end
end
