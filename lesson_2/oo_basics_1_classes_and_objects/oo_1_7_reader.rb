# Use previous code. Add getter method; invoke it instead of `@name` in #greet.

class Cat
  attr_reader :name
  
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
