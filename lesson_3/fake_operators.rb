require 'pry'

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  # overwriting shift method
  def <<(person)
    members << person
  end

  # overwriting plus `+` method
  def +(other_team)
    temp_team = Team.new("Temp team")
    temp_team.members = members + other_team.members
    temp_team
  end

  # overwriting getter method []
  def [](idx)
    members[idx]
  end


  def []=(idx, obj)
    members[idx] = obj
  end

  def test(idx)
    members(idx)
  end
end

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  # overwriting comparison operators
  def >(other_person)
    # binding.pry
    age > other_person.age
  end

  def <(other_person)
    age < other_person.age
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Troy Aikman", 48)

# p cowboys.members

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)

dream_team = niners + cowboys
# puts "The dream team..."
# # p dream_team

# # p cowboys[1]
# cowboys[2] = Person.new('JJ', 72)
# p cowboys[2]

# p cowboys[1] > cowboys[2]
