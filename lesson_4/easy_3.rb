# 1) What happens in all the following cases?

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# Case 1
hello = Hello.new
hello.hi # => "Hello"

# Case 2
hello = Hello.new
# hello.bye # => NoMethodError (`#bye` is only accessible to objects of the Goodbye class)

# Case 3
hello = Hello.new
# hello.greet # => ArgumentError (`greet` requires 1 arg)

# Case 4
hello = Hello.new
hello.greet("Goodbye") # => "Goodbye"

# Case 5
# Hello.hi # => NoMethodError (`Hello.hi` would invoke a class method if one existed, but none are defined)

=begin
See in line comments above for each case. Lines have been commented out so this file can execute as needed.
=end


# 2) How could we fix the `Hello` class from above so that `Hello.hi` would execute?

class Hello < Greeting
  def hi
    greet("Hello")
  end

  def self.hi
    puts "Hi!"
  end
end

Hello.hi

=begin
A class method had to be defined using the `def self.hi` line. The method logic isn't important here, but there is now a class method available.

Interestingly, can't invoke `greet('Hi!')` from the `Hello::hi` method because `Greeting#greet` is only available to instances.
=end


# 3) How do you create 2 different instances of this class with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hissss!"
  end
end

mad1 = AngryCat.new(3, 'Ginger')
mad2 = AngryCat.new(5, 'Growly')

=begin
Easiest way is to just initialize new local variables the point to a new object reference and use those (like above).
=end


# 4) How can we change the `to_s` output of this class to look like this: "I am a tabby cat" (assuming `tabby` is the `type` we pass during initialization).

class Cat
  def initialize(type)
    @type = type
  end

  # adding `to_s` for specific display
  def to_s
    "I am a #{@type} cat"
  end
end

new_cat = Cat.new('tabby')
puts new_cat

=begin
Need to overwrite `to_s` by defining a new method by that name in the class. This lets you customize what gets output when `to_s` is invoked on objects of that class.
=end


# 5) What happens if we call methods below?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
# tv.manufacturer # => NoMethodError
tv.model # => executes (no logic in method)

Television.manufacturer # => executes (no logic in method)
# Television.model # => NoMethodError

=begin
See in-line comments above. The `Television::manufacturer` method is a class method and can only be invoked on the actual class, `Television`. The `Television#model` method is an instance method and can only be invoked on objects of the `Television` class (like `tv` in our example).
=end


# 6) How else could we write the `make_one_year_older` method to not use the `self` prefix?

class BigCat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age = 0
  end

  def make_one_year_older
    # self.age += 1 # Commenting out
    @age += 1
  end
end

=begin
You can reference the `@age` instance variable directly using `@age`. However, this is not the preferred method when we have a setter method to adjust the state already (we do through the `attr_accessor :age` statement)
=end


# 7) What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

=begin
In the code above, the class method `Light::information` is not adding value. Each instance of a light has access to the variables `@brightness` and `@color`. However, the class method doesn't interact with instances of the Light object that have access to the given instance variables.

Also, the explicit `return` in the `Light::information` method is unneeded.
=end
