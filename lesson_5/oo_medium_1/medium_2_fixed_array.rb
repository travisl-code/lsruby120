class FixedArray
  attr_reader :fixed_arr

  def initialize(num)
    arr = []
    num.times { arr << nil }
    @fixed_arr = arr
  end

  def [](index)
    if index > fixed_arr.size
      raise IndexError
    else
      fixed_arr[index]
    end
  end

  def []=(index, value)
    if index > fixed_arr.size
      raise IndexError
    else
      @fixed_arr[index] = value
    end
  end

  def ==(other)
    fixed_arr == other.fixed_arr
  end

  def to_a
    fixed_arr.dup
  end

  def to_s
    fixed_arr.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

=begin
Write `FixedArray` class (has fixed number of elements). Write methods to support the code above. It should output true 16 times.

This one required methods were the to_a, to_s, the element getter/setter (which both require raising an exception for values beyond the fixed array's size), and lastly the == method for comparison.
=end
