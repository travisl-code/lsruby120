# Create Towable module with `tow` method that prints "I can tow a trailer!". Include in Truck class

module Towable
  def tow
    puts "I can tow a trailer!"
  end
end

class Truck
  include Towable
end

class Car
end

truck1 = Truck.new
truck1.tow