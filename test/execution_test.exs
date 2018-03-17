defmodule Calc.ExecutionTest do
  use ExUnit.Case, async: true

  test "you can execute an expression" do
    assert Calc.execute("(14 + 10) * 8") == 192
  end
end
