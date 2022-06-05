class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(y, m, c)
    @year = y
    @model = m
    @color = c
    @speed = 0
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def to_s
    "#{color} #{year} #{model}"
  end
end

t_car = MyCar.new('1998', 'Honda Accord', 'white')
MyCar.gas_mileage(12, 431)
puts t_car # => white 1998 Honda Accord
