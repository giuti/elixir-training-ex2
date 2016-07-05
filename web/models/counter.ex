defmodule Countdown.Counter do

  def start_link do
    Agent.start_link(fn -> %{value: 0} end, name: __MODULE__)
  end

  def reset do
    Agent.update(__MODULE__, fn (value) -> 0 end, 7500)
  end

  def value do
    Agent.get(__MODULE__, fn (value) -> value end, 7500)
  end

  def limit do
    100
  end

  def count do
    n = value + 1
    if n < limit do
      Agent.update(__MODULE__, fn value -> n end, 7500)
      {:ok, n}
    else
      reset
      {:overflow, 0}
    end
  end

  def set(n) do
    Agent.update(__MODULE__, fn value -> n end, 7500)
  end
end

# http://dantswain.herokuapp.com/blog/2015/01/06/storing-state-in-elixir-with-processes/
# http://elixir-lang.org/getting-started/mix-otp/agent.html
# https://elixirschool.com/
