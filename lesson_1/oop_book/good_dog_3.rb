class GoodDog
  @@number_of_dogs = 0

  def initialize(name)
    @name = name
    @@number_of_dogs += 1
  end

  # This is a class method
  def self.what_am_i
    "I'm a GoodDog class!"
  end

  def self.total_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_dogs # => 0
dog1 = GoodDog.new("Sparky")
dog2 = GoodDog.new("Fido")
puts GoodDog.total_dogs # => 2

puts dog1

# puts GoodDog.what_am_i