defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  def compile(expression, mod) when is_atom(mod) do
    with {:ok, tokens} <- expression_to_tokens(expression),
         {:ok, ast} <- tokens_to_ast(tokens),
         ast <- wrap_in_defmodule(ast, mod),
         [{mod, _bin}] <- Code.compile_quoted(ast),
         do: mod
  end

  def execute(expression) do
    with {:ok, tokens} <- expression_to_tokens(expression),
         {:ok, ast} <- tokens_to_ast(tokens),
         {result, []} <- Code.eval_quoted(ast),
         do: result
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

  defp wrap_in_defmodule(ast, mod) do
    {:defmodule, [context: Elixir, import: Kernel],
     [
       {:__aliases__, [alias: false], [mod]},
       [
         do: {:def, [context: Elixir, import: Kernel],
          [
            {:run, [context: Elixir], Elixir},
            [do: ast]
          ]}
       ]
     ]}
  end
end
