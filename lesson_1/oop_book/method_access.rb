class GoodDog
  attr_accessor :name, :age
  def initialize(n, a)
    self.name = n
    self.age = a
  end

  private

  def human_years
    age * 7
  end
end

# sparky = GoodDog.new('Sparky', 4)
# p sparky.human_years # exception private method `human_years' called for object

class Person
  def initialize(a)
    @age = a
  end

  def older?(other_person)
    age > other_person.age
  end

  protected
  attr_reader :age
end

malory = Person.new(64)
sterling = Person.new(42)
p malory.older?(sterling) # => true
p sterling.older?(malory) # => false
malory.age # NoMethodError