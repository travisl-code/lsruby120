# Write classes and methods to make this code run and print the following (order of output not important as long as all info is present):

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.

require 'pry'

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "#{type} named #{name}"
  end
end

class Owner
  attr_accessor :number_of_pets
  attr_reader :name

  def initialize(name)
    @name = name
    @number_of_pets = 0
    @pets = []
  end

  def new_pet(new_pet)
    self.number_of_pets += 1
    self.pets=(new_pet)
  end

  def to_s
    name
  end

  private
  def pets=(adopted_pet)
    @pets << adopted_pet
  end
end

class Shelter
  def initialize
    @adoptions = {}
  end

  def adopt(new_owner, pet)
    new_owner.new_pet(pet)
    @adoptions[new_owner.name] ? @adoptions[new_owner.name] << pet : @adoptions[new_owner.name] = [pet]
  end

  def print_adoptions
    @adoptions.each do |owner, pets|
      puts "#{owner} has adopted the following pets:"
      pets.each { |pet| puts "a #{pet}"}
      puts "\n"
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
