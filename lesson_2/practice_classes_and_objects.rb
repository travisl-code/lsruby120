class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_splitter(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    name_splitter(name)
  end

  def to_s
    name
  end

  private
  def name_splitter(name)
    names = name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end
end

# ----------------------------------- 

# Exercise 1
=begin
class Person
  attr_accessor :name

  def initialize(n)
    @name = n
  end
end
=end
# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'

# Exercise 2
=begin
class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    names = name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end
=end
# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# Exercise 3
=begin
class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_splitter(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    name_splitter(name)
  end

  private
  def name_splitter(name)
    names = name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end
end
=end
# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'

# Exercise 4
# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# p bob.name == rob.name

# Exercise 5
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"