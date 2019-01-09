defmodule Rpn.Calculator do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def push(operand) when is_number(operand) or is_atom(operand) do
    GenServer.call(__MODULE__, {:push, operand})
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:push, :+}, _from, [o1, o2 | t]) when is_number(o1) and is_number(o2) do
    new_state = [o2 + o1 | t]
    {:reply, new_state, new_state}
  end

  def handle_call({:push, :-}, _from, [o1, o2 | t]) when is_number(o1) and is_number(o2) do
    new_state = [o2 - o1 | t]
    {:reply, new_state, new_state}
  end

  def handle_call({:push, :*}, _from, [o1, o2 | t]) when is_number(o1) and is_number(o2) do
    new_state = [o2 * o1 | t]
    {:reply, new_state, new_state}
  end

  def handle_call({:push, :/}, _from, [o1, o2 | t]) when is_number(o1) and is_number(o2) do
    new_state = [o2 / o1 | t]
    {:reply, new_state, new_state}
  end

  def handle_call({:push, :=}, _from, [result]) do
    new_state = []
    {:reply, result, new_state}
  end

  def handle_call({:push, operand}, _from, state) when is_number(operand) do
    new_state = [operand | state]
    {:reply, new_state, new_state}
  end

  def handle_call({:push, _op}, _from, state) do
    {:reply, state, state}
  end
end
