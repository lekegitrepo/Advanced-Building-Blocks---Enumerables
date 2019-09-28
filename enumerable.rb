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
      my_each { count += 1 }
    else
      my_each { |i| count += 1 if i == items }
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

new_arr_each = []

[4, 5, 8, 2, 1, 9, 3, 7, 6].my_each { |i| new_arr_each << i**2 if i < 5 }

p new_arr_each
