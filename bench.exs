expression = "(55.50 / 16.32) + 84 * 3 / 2.0"
Calc.compile(expression, MyMod)

Benchee.run(%{
  "evaluate"    => fn -> Calc.execute(expression) end,
  "compiled" => fn -> MyMod.run() end
}, time: 10)
