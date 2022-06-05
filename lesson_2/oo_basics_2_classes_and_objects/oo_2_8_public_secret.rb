# Create Person class with @secret instance variable. Use setter to add value to that inst variable and getter to print it.

class Person
  attr_accessor :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret
