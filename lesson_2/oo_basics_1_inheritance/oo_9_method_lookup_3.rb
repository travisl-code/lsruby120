# Determine lookup path when invoking `bird1.color`. Only list classes Ruby checks.

# Bird > Flyable > Animal

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color
