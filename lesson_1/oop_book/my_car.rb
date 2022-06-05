class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(year, color, model)
    @speed = 0
    @year = year
    @color = color
    @model = model
  end

  def info
    "The #{year} #{color} #{model} car is going #{speed}."
  end

  def spray_paint(new_color)
    puts "Let's turn that #{color} #{model} #{new_color}!"
    self.color = new_color
  end

  def speed_up(mph)
    self.speed += mph
    "You sped up; you're now going #{speed}."
  end

  def brake(mph)
    self.speed = mph
    "You slowed down; you're now going #{speed}."
  end
end

travis_car = MyCar.new('2001', 'silver', 'Civic')
# puts travis_car.color
# travis_car.color = 'white'
# puts travis_car.color
# puts travis_car.info
# puts travis_car.speed_up(60)
# puts travis_car.info
# puts travis_car.brake(0)
# puts travis_car.info
travis_car.spray_paint('white')
puts travis_car.info

## This was an example of namespacing
# module Career
#   class Engineer
#   end

#   class Teacher
#   end
# end

# new_obj = Career::Teacher.new
