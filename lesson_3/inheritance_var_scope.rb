class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! #{@name} bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name # => "bark! Teddy bark!"

module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Cat
  include Swim
  def swim
    "swimming!" if @can_swim
  end
end

pooh = Cat.new
pooh.swim # => nil b/c @can_swim not initialized
pooh.enable_swimming
pooh.swim # => "swimming!"

class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels # => 2
Vehicle.wheels # => 2 !! Not 4

module FourWheeler
  WHEELS = 4
end

class Vehicle
  def maintenance
    "Changing #{WHEELS} tires."
  end
end

class Car < Vehicle
  include FourWheeler

  def wheels
    WHEELS
  end
end

car = Car.new
puts car.wheels # => 4
puts car.maintenance # => NameError
