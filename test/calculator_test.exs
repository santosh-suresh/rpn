defmodule RpnTest.Calculator do
  use ExUnit.Case
  alias Rpn.Calculator

  setup do
    Calculator.start_link()
    :ok
  end

  test "pushes only numbers to the calculator" do
    assert [10] == Calculator.push(10)
  end

  test "pushing non number does not add to current state" do
    Calculator.push(10)
    Calculator.push(20)
    assert [20, 10] = Calculator.push(:invalid)
  end

  test "pushing an operator without operands returns current state" do
    assert [] = Calculator.push(:*)
  end

  test "valid expression returns the result" do
    Calculator.push(5)
    Calculator.push(5)
    Calculator.push(3)
    Calculator.push(:+)
    Calculator.push(:*)
    assert 40 == Calculator.push(:=)
  end
end
