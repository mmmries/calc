defmodule Calc.CompileTest do
  use ExUnit.Case, async: true

  test "compiling an expression" do
    assert Calc.compile("1.5 * 6.0 / (2.0 + 0.5)", CalcFoo) == CalcFoo
    assert CalcFoo.run() == 3.6
  end
end
