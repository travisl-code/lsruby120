# Add appropriate access methods

class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name
