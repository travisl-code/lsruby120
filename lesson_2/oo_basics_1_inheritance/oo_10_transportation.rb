# Create module Transportation containing 3 classes: Vehicle, Truck, and Car. Truck and Car should inherit from Vehicle

module Transportation
  class Vehicle
  end

  class Car < Vehicle
  end

  class Truck < Vehicle
  end
end

# Namespacing within module. Instantiate new object like this:
Transportation::Truck.new