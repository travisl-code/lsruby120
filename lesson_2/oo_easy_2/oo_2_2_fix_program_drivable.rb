# Fix so it works. Assume Car class has complete implementation; should access `drive` method.

module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
