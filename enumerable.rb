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

  def my_count(items = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) == true }
    elsif items.nil?
      my_each { |_i| count += 1 }
    else
      my_each { |i| count if i == items }
    end
    count
  end

  def my_map(arg = nil)
    return :my_map unless block_given?

    arr = []
    my_each do |i|
      arr << if !arg.nil?
               arg.call(i)
             else
               yield(i)
      end
    end
    arr
  end

  def my_inject(*args)
    arr = to_a.dup
    if args[0].nil?
      operand = arr.shift
    elsif args[1].nil? && !block_given?
      symbol = args[0]
      operand = arr.shift
    elsif args[1].nil? && block_given?
      operand = args[0]
    else
      symbol = args[0]
      operand = args[1]
    end

    arr[0..-1].my_each do |i|
      operand = if symbol
                  operand.send(symbol. i)
                else
                  yield(operand, i)
                end
    end
    operand
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

# puts multiply_els([2, 4, 5])
