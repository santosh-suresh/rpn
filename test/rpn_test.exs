defmodule RpnTest do
  use ExUnit.Case
  doctest Rpn

  setup do
    Rpn.Calculator.start_link()
    :ok
  end

  test "evaluate an expression" do
    Rpn.evaluate("15 7 1 1 + - / 3 x 2 1 1 + + -")
    assert 5 == Rpn.Calculator.push(:=)
  end
end
