# Use previous code. Add setter method #name=. Rename kitty to 'Luna' and greet again.

class Cat
  attr_reader :name
  attr_writer :name
  
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet
