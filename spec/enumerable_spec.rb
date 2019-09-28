# frozen_string_literal: true

require './enumerable'

RSpec.describe Enumerable do
  let(:arr) { [4, 5, 8, 2, 1, 9, 3, 7, 6] }
  let(:new_arr) { [] }

  describe '#my_each' do
    let(:new_arr_each) { [] }
    it 'iterate through array elements' do
      my_array = []
      original_array = []
      arr.my_each { |n| my_array << n * 2 }
      arr.each { |n| original_array << n * 2 }
      expect(my_array).to eql(original_array)
    end
  end

  describe '#my_each_with_index' do
    it 'returns indexes of elements in an array' do
      %w[mi cro ver se].my_each_with_index { |_elem, index| new_arr << index }
      expect(new_arr).to eql([0, 1, 2, 3])
    end
  end

  describe '#my_count' do
    it 'return the count of elements that evalute to true' do
      expect(arr.my_count { |i| i < 6 }).to eq(5)
    end
  end

  describe '#my_map' do
    it 'returns a new array with the results of running through the block once on a given array' do
      answer = arr.my_map { |num| num**2 }
      expect(answer).to eql(arr.map { |num| num**2 })
    end
  end

  describe '#my_none' do
    it 'returns true if none of the elements meet criteria defined in the block' do
      expect(arr.my_none? { |num| num == 10 }).to eq(true)
    end
  end

  describe '#my_select' do
    it 'return selected value in an array base on the given block' do
      expect(arr.my_select(&:odd?)).to eq([5, 1, 9, 3, 7])
    end
  end
end
