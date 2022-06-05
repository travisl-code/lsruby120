# Use code from before. Move greeting from initialize method into instance method named #greet

class Cat
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
