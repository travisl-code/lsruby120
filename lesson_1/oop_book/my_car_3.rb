module Offroadable
  def splish_splash
    puts "Through the water!"
  end

  def four_wheel_drive
    puts "We're using 4WD"
  end
end

class Vehicle
  @@total_vehicles = 0

  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(y, m, c)
    @@total_vehicles += 1
    @year = y
    @model = m
    self.color = c
    self.speed = 0
  end

  def speed_up(mph)
    self.speed += mph
    puts "You speed up to #{speed}."
  end

  def speed_down(mph)
    self.speed -= mph
    puts "You slow down to #{speed}"
  end

  def park_vehicle
    self.speed = 0
    puts "You park the car!"
  end

  def to_s
    "#{color} #{year} #{model}"
  end

  def self.vehicle_count
    @@total_vehicles
  end

  def spray_paint(color)
    self.color = color
    puts "New color of #{self} is #{color}."
  end

  def age
    puts "This vehicle is #{how_old} years old."
  end

  private
  def how_old
    current_year = Time.new.year
    current_year - year.to_i
  end
end

class MyCar < Vehicle
  TYPE = 'sedan'

end

class MyTruck < Vehicle
  BED_LENGTH = '56 in'
  include Offroadable


end

t_car = MyCar.new('1998', 'Honda Accord', 'white')
puts t_car
r_truck = MyTruck.new('1996', 'Nissan Pathfinder', 'white')
puts r_truck

# For exercise 2
# p Vehicle.vehicle_count
# r_truck.spray_paint('red')
# puts r_truck

# For exercise 3
# r_truck.four_wheel_drive
# r_truck.splish_splash

# For exercise 4
# puts Vehicle.ancestors
# puts "__________________"
# puts MyCar.ancestors
# puts "__________________"
# puts MyTruck.ancestors
# puts "__________________"
# puts Offroadable.ancestors

# For exercise 5
# t_car.speed_up(35)
# t_car.speed_down(20)
# puts t_car.speed
# t_car.park_vehicle
# puts t_car.speed

# For exercise 6
# t_car.how_old # Exception as expected
# t_car.age 
