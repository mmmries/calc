defmodule Calc do
  def compile(expression, mod) when is_binary(expression) and is_atom(mod) do
    {:ok, ast} = parse(expression)
    ast = wrap_ast_in_def(ast, mod)
    Code.compile_quoted(ast)
  end

  def eval(expression, variables) when is_binary(expression) do
    {:ok, ast} = parse(expression)
    eval(ast, variables)
  end
  def eval(ast, variables) when is_tuple(ast) do
    ast = wrap_vars(ast)
    {ret, _} = Code.eval_quoted(ast, vars: variables)
    ret
  end

  def interpret(expression, variables) when is_binary(expression) do
    {:ok, ast} = parse(expression)
    interpret(ast, variables)
  end
  def interpret(ast, variables) when is_tuple(ast) do
    Calc.Interpreter.run(ast, variables)
  end

  def parse(expression) when is_binary(expression) do
    with {:ok, tokens} <- expression_to_tokens(expression),
         {:ok, ast} <- tokens_to_ast(tokens),
         do: {:ok, ast}
  end

  def expression_to_tokens(expression) when is_binary(expression) do
    expression = String.to_charlist(expression)
    case :calc_tokenizer.string(expression) do
      {:ok, tokens, _} -> {:ok, tokens}
      other -> raise other
    end
  end

  def tokens_to_ast(tokens) when is_list(tokens) do
    :calc_parser.parse(tokens)
  end

  defp wrap_ast_in_def(ast, mod) do
    {:defmodule, [context: Elixir, import: Kernel],
     [
       {:__aliases__, [alias: false], [mod]},
       [
         do: {:def, [context: Elixir, import: Kernel],
          [
            {:run, [context: Elixir], [{:vars, [], Elixir}]},
            [
              do: ast
            ]
          ]}
       ]
     ]}
  end

  defp wrap_vars({:vars, _, :Elixir}) do
    {:var!, [context: Elixir, import: Kernel], [{:vars, [], Elixir}]}
  end
  defp wrap_vars({op, ctx, args}) do
    args = Enum.map(args, &wrap_vars/1)
    {op, ctx, args}
  end
  defp wrap_vars(other), do: other
end
