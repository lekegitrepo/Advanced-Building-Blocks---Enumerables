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
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    item_select = []
    my_each { |i| item_select << i if yield(i) }
    item_select
  end

  def my_all?
    items = true
    my_each do |i|
      if i == false || i == nil
        items = false
      end
    end
    items
  end

  def my_any?
    i = 0
    items = false
    while i < size
      if yield(self[i])
        items = true
      end
      i += 1
    end
    items
  end

  def my_none?
    i = 0
    items = true
    while i < size
      if yield(self[i])
        items = false
      end
      i += 1
    end
    items
  end

  def my_count
    count = 0
    my_each do |i|
      if block_given? && yield(i)
        count += 1
      else
        self.size
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

  def multiply_els
    var = 0
  end
end
