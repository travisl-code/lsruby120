# Modify code to print "Hello! I'm a cat!" when #generic_greeting is invoked

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

kitty = Cat.new
Cat.generic_greeting

# This outputs the greeting as well
# kitty.class returns the Cat class, and we chain the class method to that return.
kitty.class.generic_greeting
