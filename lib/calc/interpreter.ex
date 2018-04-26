defmodule Calc.Interpreter do
  def run(num, _vars) when is_integer(num), do: num
  def run(num, _vars) when is_float(num), do: num
  def run({{:., _, _}, _, [_, name]}, vars), do: Map.fetch!(vars, name)
  def run({:+, _, [left, right]},vars), do: run(left,vars) + run(right,vars)
  def run({:-, _, [left, right]},vars), do: run(left,vars) - run(right,vars)
  def run({:*, _, [left, right]},vars), do: run(left,vars) * run(right,vars)
  def run({:/, _, [left, right]},vars), do: run(left,vars) / run(right,vars)
  def run({:>, _, [left, right]},vars), do: run(left,vars) > run(right,vars)
  def run({:>=, _, [left, right]},vars), do: run(left,vars) >= run(right,vars)
  def run({:<, _, [left, right]},vars), do: run(left,vars) < run(right,vars)
  def run({:<=, _, [left, right]},vars), do: run(left,vars) <= run(right,vars)
end
