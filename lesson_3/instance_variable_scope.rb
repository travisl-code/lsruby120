class Person
  @name = 'Bob'
  def get_name
    @name
  end
end

bob = Person.new
bob.get_name # => nil

class Worker
  @@total_workers = 0 # Initialized at class

  def self.total_workers
    @@total_workers # Accessible from class method
  end

  def initialize
    @@total_workers += 1 # Mutable from instance method
  end

  def total_workers
    @@total_workers # Accessible from instance method
  end
end

module ElizabethanEra
  GREETINGS = ['How dost thou', 'Bless thee', 'Good morrow']

  class Greeter
    def self.greetings
      GREETINGS.join(', ')
    end

    def greet
      GREETINGS.sample
    end
  end
end

puts ElizabethanEra::Person.greetings # => "How dost though, ..."
puts ElizabethanEra::Person.new.greet # => 'Bless thee' (or other)

# puts Greeter.greetings # => 'Hi, Hello, Hey'
# puts Greeter.new.greet # => 'Hi' (or other option)

class Computer
  GREETINGS = ['Beep', 'Boop']
end

class Human
  def greet
    GREETINGS.sample
  end
end

puts Human.new.greet # => NameError