class Animal
  def initialize(n)
    @name = n
  end
end

class GoodDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

class Cat < Animal
end

# sparky = GoodDog.new
# paws = Cat.new
# puts sparky.speak
# puts paws.speak

bear = GoodDog.new(3, 'Bear')
p bear

