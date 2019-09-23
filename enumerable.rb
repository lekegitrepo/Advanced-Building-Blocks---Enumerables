# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    item_select = []
    my_each { |i| item_select << i if yield(i) }
    item_select
  end

  def my_all?(param = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif param.class == Class
      my_each { |i| return false unless i.class == param }
    elsif param.class == Regexp
      my_each { |i| return false unless i =~ param }
    elsif param.nil?
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless i == param }
    end
    true
  end

  def my_any?(param = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif param.class == Class
      my_each { |i| return true if i.class == param }
    elsif param.class == Regexp
      my_each { |i| return true if i =~ param }
    elsif param.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if i == param }
    end
    false
  end

  def my_none?(param = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif param.class == Class
      my_each { |i| return false if i.class == param }
    elsif param.class == Regexp
      my_each { |i| return false if i =~ param }
    elsif param.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i == param }
    end
    true
  end

  def my_count
    count = 0
    my_each do |i|
      if block_given? && yield(i)
        count += 1
      else
        size
      end
    end
    count
  end

  def my_map
    items = []
    my_each { |i| items << i if yield(i) }
    items
  end

  def my_map_proc(&proc_block)
    items = []
    my_each { |i| items << proc_block.call(i) }
    items
  end

  def my_map_block(param = nil)
    i = 0
    items = []
    while i < size
      if param.nil? && block_given?
        items << yield(self[i])
      elsif !param.nil && block_given?
        items << param.call(self[i])
      end
      i += 1
    end
    items
  end

  def my_inject(init = self[0])
    value = init
    my_each do |i|
      next if init == i

      value = yield(value, i)
    end
    value
  end
end

def multiply_els(arr)
  arr.my_inject { |a, b| a * b }
end

# Implementation Tests for the methods
# arr = [1, 2, 3, 4, 5]

# arr.my_each { |x| puts x * 2 }

# arr.my_each_with_index {| i,j | puts i.to_s + " " + j.to_s }

# arr.my_select { |i| puts i % 2 == 0 }

# arr.my_all? { |i| puts i > 2 } # => false

# arr.my_any? { |i| puts i < 0 } # => false

# puts arr.my_none?{|a| a.nil? } # => true

# puts arr.my_count # => 5

# puts arr.my_map { |i| i * 2} # => [2, 4, 6, 8, 10]

# puts multiply_els([2,4,5])
