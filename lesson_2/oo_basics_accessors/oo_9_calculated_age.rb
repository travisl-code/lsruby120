# Multiply @age by 2 upon assignment; mulitiply @age by 2 again when @age is returned by getter

class Person
  def age=(a)
    @age = a * 2
  end

  def age
    @age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age
