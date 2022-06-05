# Created Cat class; print greeting when #greet is invoked. Greeting should include constant as color of cat.

class Cat
  COLOR = 'purple'

  attr_reader :name

  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
