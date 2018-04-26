expression = "(55.50 / 16) + a * b / 2.0"
variables = %{a: 5, b: 7}
{:ok, ast} = Calc.parse(expression)
Calc.compile(expression, MyModule)

Benchee.run(%{
  "parse"     => fn -> Calc.parse(expression) end,
  "compile"   => fn -> Calc.compile(expression, OtherModule) end,
  "interpret" => fn -> Calc.interpret(ast, variables) end,
  "eval"      => fn -> Calc.eval(ast, variables) end,
  "compiled"  => fn -> MyModule.run(variables) end,
}, time: 10, memory_time: 2)
