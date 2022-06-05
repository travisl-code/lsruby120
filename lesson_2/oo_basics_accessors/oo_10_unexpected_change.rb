# Modify code to accept string of first and last name. Name should be split into two instance variables in the setter method, then joined in the getter to form full name

class Person
  # attr_accessor :name
  def name=(name)
    full = name.split
    @first_name = full.first
    @last_name = full.size > 1 ? full.last : ''
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
