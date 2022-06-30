# 1) Implement new vehicle type -- `Catamaran` -- as new class. Still want common code to track fuel efficiency and range. Modify class definitions and move code into module as necessary.

# New module to include in WheeledVehicle class
module Fueled
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  # attr_accessor :speed, :heading # removed, part of Moveable module

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter # using setter now
    self.fuel_capacity = liters_of_fuel_capacity # using setter now
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

  # Moving out of class
  # def range
  #   @fuel_capacity * @fuel_efficiency
  # end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20, 20], 80, 8.0)
  end
end

class Catamaran
  include Moveable

  attr_reader :propeller_count, :hull_count
  # attr_accessor :speed, :heading # removed, part of Moveable module

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # code omitted
  end
end

=begin
The only common behavior I see is getting the range (distance vehicle can travel). This is included in both the `WheeledVehicles` and `Catamaran` class. However, it feels like what would make even more sense would be to have a parent class (or a rework of the `WheeledVehicle` class) that all Vehicles subclass from. This could include the instance variables like `@speed` and `@heading`, as well as fuel-related variables.

LS solution moves the `@speed` and `@heading` variables, as well as the fuel variables `@fuel_efficiency` and `@fuel_capacity`, and these getter/setter methods into the Movable class, along with the `#range` instance method.
=end


# 2) Building on previous code, how could we add a Motorboat class (has single propeller and hull, but otherwise like catamaran). How to modify the code to incorporate this new class?

class FloatingVehicle2
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end

class Catamaran2 < FloatingVehicle2
  # `initialize` no longer needed
  # def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  #   super
  # end
end

class Motorboat < FloatingVehicle2
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

=begin
I think it makes sense in this case to create a new parent class for all boat-like vehicles (I named it FloatingVehicle). Then, we can include the `Moveable` module in this parent class and subclass the Motorboat and Catamaran classes. This lets us have a common format for `initialize`. It could also let there be common states and behaviors for these types of vehicles.
=end


# 3) The `Moveable#range` method needs to be modified that sea vehicles get an additional 10km of range even when out of fuel. Leave the autos/motorcycles code calculated as before.

class FloatingVehicle3
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end

  def range
    super + 10
  end
end

class Motorboat3 < FloatingVehicle3
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

boat = Motorboat3.new(60, 40)
p boat.range

=begin
I think it makes the most sense to implement some polymorphism and override the default behavior of the range method. We can do this by defining it within the class and (I think) invoking the super method on it.
=end
