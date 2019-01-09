defmodule Rpn do
  def evaluate(expression) do
    expression
    |> String.split(" ")
    |> Enum.map(&convert/1)
    |> IO.inspect()
    |> Enum.each(&Rpn.Calculator.push/1)
  end

  defp convert("+"), do: :+
  defp convert("-"), do: :-
  defp convert("*"), do: :*
  defp convert("x"), do: :*
  defp convert("/"), do: :/
  defp convert("="), do: :=

  defp convert(num) do
    {n, _} = Integer.parse(num)
    n
  end
end
