# Refactor Car, Motorcycle, and Truck to use a common superclass and inherit behaviors

require 'pry'

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    case self.class
    when Motorcycle then 2
    when Truck then 6
    when Car then 4
    end
  end
end

class Car < Vehicle
  # def wheels
  #   4
  # end
end

class Motorcycle
  def wheels
    2
  end
end

class Truck
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

# Further Exploration - would it make sense to define wheels in Vehicle, despite all classes overriding it? 

=begin
I think it might make sense to have a single method because it avoids duplicated code, and we could specify the returned values for each subclass. That way if more subclasses are made, we can have a default value and/or modify in one place the wheels method.

This was my proposed solution, but I've now learned that `case` uses the `===` method, which has different functionality from `==`. This doesn't work, and only an `else` clause would get executed. I believe `===` would be similar to `to_s`, needing to be defined within classes. Questions asked in Slack.

def wheels
  case self.class
  when Motorcycle then 2
  when Truck then 6
  when Car then 4
  end
end
=end

my_car = Car.new('Honda', 'Civic')
p my_car.wheels
