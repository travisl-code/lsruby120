# Determine lookup path when invoking `cat1.color`. Only list the classes that were checked by Ruby.

# Cat > Animal (next would be object > kernel > BasicObject)

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color
