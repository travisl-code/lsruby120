# Fix to work properly

=begin
This is the problem code:
  def increment_mileage(miles)
    total = mileage + miles
    mileage = total
  end

The issue is that mileage is initialized as a local variable in this method, and is assigned to the value of total. This is not the intended behavior, but to get around it and treat that statement as a setter for the `@mileage` instance variable, we need to prepend `self.` to it.

Note: could also assign to @mileage, but the setter is usually better if it's available, because it may have its own implementation details (like converting value to integer -- although that's not the case in this example).
=end

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
