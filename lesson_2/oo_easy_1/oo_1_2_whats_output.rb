# What output is printed? Fix class
=begin
This is the erroneous code:

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end

The problem is that when `puts` is invoked, it calls `to_s` on the object to it as an argument. In this implementation, the String#upcase! method mutates the string object referenced by @name, which makes the name permanently uppercased.
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!
    "My name is #{@name}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

# Further Explore - what happens here?
=begin
The `initialize` method in the Pet class converts the integer 42 into a string, which will be a new object that gets stored to the variable @name. @name and name do not reference the same object. The puts calls to the object `fluffy` will output 42 (and will use the to_s method for Line 41). `puts name` on Line 43 will just output 43, the value referenced by the local variable `name`.
=end
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name