# 1) Which are objects in Ruby? If they are, how to see what class they belong to?

=begin
1. true
2. 'hello'
3. [1, 2, 3, 'happy days']
4. 142

All are objects; you can see verify with the `#object_id` method. To see the class they belong to, invoke the `#class` method on them.
=end


# 2) How can we give Car and Truck class objects the ability to `go_fast` using the `Speed` module? How can you check if they can now go fast?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

=begin
To give the `Car` and `Truck` classes access to the `Speed` module and its associated `go_fast` instance method, we include the module in the classes using the `include Speed` statement.

If I'm understanding the 2nd part of the question right, you can see if it has access by invoking the #ancestors method on an object of those classes.
=end


# 3) In the example of the `Speed` module included in the `Car` class above, the string that is printed when we invoke `go_fast` includes the name of the type of vehicle we're using. How is this done?

Car.new.go_fast # => I am a Car and going super fast!

=begin
The string that is created in the `Speed` module (which is in turn output by the `puts` method) includes some string interpolation through `"#{self.class}"`. What happens here is that the Car object we create has access to the `go_fast` method defined in the module. When we invoke `go_fast`, the calling object is that instance of the Car class. It can be referenced through `self`, and when we use the method `#class` on `self`, it returns the name of the class the object belongs to (`Car`). String interpolation invokes `to_s` on that object to be output. This is also why "Car" is capitalized in the output.
=end


# 4) If we have this `AngryCat` class, how do we create a new instance of this class?

class AngryCat
  def hiss
    puts "Hissssss!"
  end
end

bad_cat = AngryCat.new

=begin
Invoke the `AngryCat#new` method to instantiate a new AngryCat.
=end


# 5) Which of these classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

hot_pizza = Pizza.new('cheese')
orange = Fruit.new('apple')

p hot_pizza.instance_variables
p orange.instance_variables

=begin
The `Pizza` class has the instance variable `@name`. Instance variables are defined/accessed with the `@` sign. The `Fruit` class just has a local variable `name` that will be discarded after a Fruit object is initialized.

You can also see the instance variables for an object by invoking the `#instance_variables` method on an object. See above (New info)
=end


# 6) What could we add to the class below to access the instance variable `@volume`?

class Cube
  attr_reader :volume # Added line

  def initialize(volume)
    @volume = volume
  end
end

big_cube = Cube.new(5000)
p big_cube.instance_variable_get("@volume")

=begin
We need an instance method to be able to access the `@volume` instance variable. This could be defined manually like this:

def volume
  @volume
end

... but Ruby has the shorthand notation for defining getters (and setters) through attr_reader (getter), attr_writer (setter), and attr_accessor (both)

## New Info ##
Although not advised, instance variables can also be accessed through the `#instance_variable_get("@name")` method. See above
=end


# 7) What is the default value of `to_s` when invoked on an object? Where could you go to find out to be sure?

puts big_cube

=begin
The default value returned by `to_s` invoked on an object will be the inspected object (like calling `#inspect`) output as a string. However, `to_s` can be overwritten from within the class definitions.

You could go into irb to be sure, or test running the code.

More accurately -- returns name of object's class and encoding of object id.
- check Ruby docs or LS's OOP book
=end


# 8) What does `self` refer to in the `make_one_year_older` method below?

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

=begin
`self` refers to the calling object. More specifically, it's being used to disambiguate the setter for `@age` vs `age` as a local variable. If the self was not there, `age` would appear to be a local variable. 
=end


# 9) What does `self` refer to in the context of this class definition below?

class GoodCat
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

=begin
In the context of the `GoodCat` class, `self` is found in a method definition as `def self.cats_count`. When `self` is used in the name of the method being defined, it is a Class Method (instead of an instance method). These methods are called on the class itself, not instances of the class (called by `Goodcat.cats_count` instead of on one of the instantiated GoodCat objects).
=end


# 10) On the class below, what would you call to create a new instance of the class?

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

trash_bag = Bag.new('white', 'plastic')

=begin
You would need to instantiate a new object like any others using the `#new` method. However, the `initialize` method is defined with 2 required parameters, so there must be 2 arguments passed to the `Bag.new` method.
=end
