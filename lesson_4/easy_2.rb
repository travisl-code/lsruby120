# 1) What is the result of the following code?

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ['eat a nice lunch', 'take a nap soon', 'stay at work late']
  end
end

oracle = Oracle.new
oracle.predict_the_future

=begin
We are not invoking `puts`, so there will be no output. A String should be returned consisting of "You will " concatenated with one of the options in the choices array. The array of strings should be returned by the `choices` and then one will be selected at random by `Array#sample`.
=end


# 2) What is the result of the following code, where RoadTrip inherits from Oracle?

class RoadTrip < Oracle
  def choices
    ['visit Vegas', 'fly to Fiji', 'romp in Rome']
  end
end

trip = RoadTrip.new
trip.predict_the_future

=begin
Similar to the previous problem, this should output one of the strings, this time from the RoadTrip class's `choices` method. Because we're invoking the `#predict_the_future` method on an object of the RoadTrip class, when `#choices` is invoked, it will search the inheritance chain from the calling object's class, to parent, to object, kernel, basicobject and execute the first one where found.
=end


# 3) How to find where Ruby looks for method when it's called? How to find object's ancestors? What is the lookup chain for `Orange` and `HotSauce`?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p HotSauce.ancestors

=begin
You can tell where Ruby looks for a method by looking at the object's ancestors, which can be found by invoking the `#ancestors` method on any class (NOT object). This provides the method lookup chain for that class, which is the order in which Classes are searched to find the referenced method. For `Orange` and `HotSauce`, the lookup chain is Orange (or HotSauce) > Taste > Object > Kernel > BasicObject.
=end


# 4) Simply this class and remove 2 methods while maintaining the same functionality.

class BeesWax
  attr_accessor :type # Added line

  def initialize(type)
    @type = type
  end

  # # Manually defined getter
  # def type
  #   @type
  # end

  # # Manually defined setter
  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

=begin
I added the line to implement the shorthand Ruby notation for creating a getter and setter method -- the `attr_accessor` line. The current implementation had the getter and setter defined manually.

It is also standard practice to refer to instance variables in a class without the `@` if there is a getter (so the `BeesWax#describe_type` method's body could also be modified).
=end


# 5) Looking at the variables below, what are the types and how do you know which is which?

=begin
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

First is a local variable; 2nd is an instance variable; 3rd is a class variable. You can tell the instance variables by the single `@` and class variables by the double `@@` symbols at the front of the name.
=end


# 6) Which of these is a class method, and how would you call a class method?

class Television
  def self.manufacturer # Class method
    # method logic
  end

  def model
    # method logic
  end
end

=begin
The method `Television::manufacturer` is a class method. You can tell because these methods include `self.` in the name of the method when it's defined; instance methods like `Television#model` do not have the `self.` reference in the method name during definition.

To invoke a class method, you need to invoke the method on the class itself, not an instance of the class: `Television.manufacturer` in this case.
=end


# 7) Explain what `@@cats_count` variable does and how it works. What code do you need to write to test theory?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

puts Cat.cats_count
cat1 = Cat.new('tabby')
puts Cat.cats_count

=begin
`@@cats_count` is a class variable. It is separate from the individual instances of Cat objects. It is tied to the Class itself, not any one object (like instance variables). In this case, `@@cats_count` is initialized to 0 in the class definition. Then, each time a new Cat object is created, it increments the `@@cats_count` class variable by 1. We have access to this class variable through the class method `Cat::cats_count`, so we can see the value of the variable through that method.

I wrote these lines to test:

puts Cat.cats_count
cat1 = Cat.new('tabby')
puts Cat.cats_count

=end


# 8) What do we add to Bingo class to allow it to inherit the `play` method from the `Game` class?

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game # added `< Game`
  def rules_of_play
    # method logic
  end
end

=begin
The Ruby syntax for class inheritance is like this: `class SubClass < ParentClass`. This sets up the parent hierarchy for a subclass. In Ruby, classes can only subclass from one parent.
=end


# 9) Using the classes from exercise 8, what would happen if we added a `play` method to the `Bingo` class (where there is already a `play` method in the inherited `Game` class.)?

=begin
This would simply overwrite the `Game#play` instance method with the `Bingo#play` instance method when `#play` is invoked on objects of the `Bingo` class. This would be an example of polymorphism I believe. 
=end


# 10) What are the benefits of using OOP in Ruby?

=begin
1) Better segmentation/containerization of code
2) Custom classes that allow for unique states and behaviors
3) More reusable code, easier to modify as well
4) Easing of complexity as the program grows
=end