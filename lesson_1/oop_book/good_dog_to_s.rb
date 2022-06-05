class GoodDog
  DOG_YEARS = 7
  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end

  def what_is_self
    self
  end

  def self.what_is_class_self
    self
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

sparky = GoodDog.new("Sparky", 3)
# puts sparky # => This dog's name is Sparky and it is 21 in dog years.
# p sparky # => #<GoodDog:0x0000563fbb1b3130 @name="Sparky", @age=21>
p sparky.what_is_self # => #<GoodDog:0x0000559ba7696a20 @name="Sparky", @age=21>
# p GoodDog.what_is_class_self