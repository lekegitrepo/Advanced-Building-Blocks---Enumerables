# frozen_string_literal: true

module Enumerables
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    var = 0
  end

  def my_select
    var = 0
  end

  def my_all?
    var = 0
  end

  def my_any?
    var = 0
  end

  def my_none?
    var = 0
  end

  def my_count
    var = 0
  end

  def my_map
    var = 0
  end

  def my_inject
    var = 0
  end

  def multiply_els
    var = 0
  end
end
