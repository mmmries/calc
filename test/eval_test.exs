defmodule Calc.EvalTest do
  use ExUnit.Case, async: true

  test "you can execute an expression with hardcoded values" do
    assert Calc.eval("(14 + 10) * 8 > 10000", []) == false
  end

  test "you can execute an expression with variables" do
    assert Calc.eval("(14 + a) * b", %{a: 10, b: 8}) == 192
  end
end
