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
    var = 0
  end

  def my_none?
    var = 0
  end

  def my_count
    var = 0
  end

  def my_map
    item_select = []
    my_each { |i| item_select << i if yield(i)}
    item_select
  end

  def my_inject
    var = 0
  end

  def multiply_els
    var = 0
  end
end
