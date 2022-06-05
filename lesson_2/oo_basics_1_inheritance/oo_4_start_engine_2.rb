# Modify #start_engine in Truck class by appending "Drive fast, please!" to return of #start_engine in Vehicle. The 'fast' in the string should be the value of `speed`.

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + ' ' + "Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')
