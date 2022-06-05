class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end


end

class Dog < Animal
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

# --------------------------------------------------

# Exercise 1 - Bulldog class, override swim method
=begin
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end
=end
# teddy = Dog.new
# puts teddy.speak           # => "bark!"
# puts teddy.swim           # => "swimming!"
# birdie = Bulldog.new
# puts birdie.speak
# puts birdie.swim


# Exercise 2 - create cat class (can't fetch or swim)
=begin
class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end


end

class Dog < Animal
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end
=end

# Exercise 3 - diagram of class hierarchy

      #       Pet
      # Dog         Cat
      # Bulldog

# Exercise 4 - what is method lookup path?
# This is seen by calling the #ancestors method on the class. This shows the order in which Ruby will search for a method name, including all possible sources of inheritance. If a subclass inherits from a superclass, the superclass will be examined after the subclass. If modules are included in any class, they will be checked from bottom to top before searching another class higher in the hierarchy.