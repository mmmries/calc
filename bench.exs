expression = "(55.50 / 16) + a * b / 2.0"
{:ok, ast} = Calc.parse(expression)

Benchee.run(%{
  "parse"     => fn -> Calc.parse(expression) end,
  "interpret" => fn -> Calc.interpret(ast, [a: 5, b: 7]) end,
  "eval"      => fn -> Calc.eval(ast, [a: 5, b: 7]) end
}, time: 10, memory_time: 2)
