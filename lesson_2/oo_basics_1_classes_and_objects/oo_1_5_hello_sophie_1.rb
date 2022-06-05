# Using previous code, add parameter to initialize to give Cat a name.

class Cat
  def initialize(n)
    @name = n
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
