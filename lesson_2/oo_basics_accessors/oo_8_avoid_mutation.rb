# @name can be modified via destructive method. Fix code so it returns copy of @name instead of ref to it.

class Person

  def initialize(name)
    @name = name
  end

  def name
    @name.dup
  end
end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name
