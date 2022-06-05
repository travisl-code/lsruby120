# Define only 1 new method in House to make output work.

# Home 1 is cheaper
# Home 2 is more expensive

class House
  attr_reader :price
  include Comparable

  def initialize(price)
    @price = price
  end

  def <=> (other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# Further Exploration - Is the technique above good? Is there another way to compare houses? Is price the only criteria you might use? Problems might run into? Classes where Comparable is a good idea.

=begin
I don't think this is a good technique for implementation. It's not obvious what is being compared. It could be number of rooms, bathrooms, sq. feet, etc.

I think it may make more sense to build a full comparison. The `<=>` method could implement a check of all the attributes in the class potentially. 
=end
