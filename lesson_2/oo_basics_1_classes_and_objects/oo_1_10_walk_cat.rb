# Use code from before. Create module `Walkable` containing method #walk that prints "Let's go for a walk!". Mix in module with Cat class, invoke

module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  attr_accessor :name

  include Walkable
  
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.walk
