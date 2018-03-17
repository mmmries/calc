defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  def execute(expression) when is_binary(expression) do
    with {:ok, tokens, _} <- expression |> String.to_charlist |> :calc_tokenizer.string,
         {:ok, ast} <- :calc_parser.parse(tokens),
         {result, []} <- Code.eval_quoted(ast),
         do: result
  end
end
