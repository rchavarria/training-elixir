defmodule PatternMatching do
  def swap({ a, b }) do
    { b, a }
  end

  def same(a, a), do: true
  def same(a, b), do: false
end
