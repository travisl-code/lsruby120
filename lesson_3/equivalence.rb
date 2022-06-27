# Comparing values of objects
str1 = 'something'
str2 = 'something'
p str1 == str2 # true

int1 = 3
int2 = 3
p int1 == int2 # true

# Comparing objects
str1.equal? str2 # false
str1_copy = str1
p str1.equal? str1_copy # true

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def ==(other_object)
    name == other_object.name
  end
end
bob1 = Person.new('Bob')
bob2 = Person.new('Bob')
bob1 == bob2 # true

# bob1_copy = bob1
# bob1.equal? bob1_copy # true

# Using ===
String === 'hello' # true
String === 15 # false