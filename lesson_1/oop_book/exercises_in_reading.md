**The Object Model**

1. How do you create an object? Give example.

Use the `class` keyword to define the class and the class method `new` to instantiate the new object.

```ruby
class Person
end

travis = Person.new
```

2. What is a module? What's its purpose? How do we use them with classes? Create module for class created in exercise 1 and include it.

Module is way to present interfaces to other classes by mixing them in. They're used by defining them with the `module` keyword and then including them in the class with the `include` keyword.

```ruby
module Dance
  def dance(type)
    puts "You're dancing #{type}!"
  end
end

class Person
  include Dance
end

travis = Person.new
travis.dance('tango')
```

**Classes and Objects - Part 1**

1. Create class MyCar. When new object of class initialized, allow user to define instance variables for year, color, model of the car. Create instance variable set to 0 during instantiation of object to track current speed of car. Create instance methods to allow car to speed up, brake, and shut off car.

```ruby
class MyCar
  attr_accessor :year, :color, :model, :engine, :speed
  def initialize(speed)
    @speed = 0
  end

  def speed_up(mph)
    self.speed = mph
  end

  def brake(mph)
    self.speed = mph
  end

  def turn_on
    self.engine = 'on'
  end

  def shut_off
    self.engine = 'off'
  end
end
```


2. 

```ruby
class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(year, color, model)
    @speed = 0
    @year = year
    @color = color
    @model = model
  end

  def info
    "The #{year} #{color} #{model} car is going #{speed}."
  end

  def speed_up(mph)
    self.speed += mph
    "You sped up; you're now going #{speed}."
  end

  def brake(mph)
    self.speed = mph
    "You slowed down; you're now going #{speed}."
  end
end
```


**Classes and Objects - Part 2**

1. Add a class method to calculate gas mileage of any car

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(y, m, c)
    @year = y
    @model = m
    @color = c
    @speed = 0
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end
end
```

2. Override the `to_s` method for a friendly print out of object.

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(y, m, c)
    @year = y
    @model = m
    @color = c
    @speed = 0
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def to_s
    "#{color} #{year} #{model}"
  end
end

t_car = MyCar.new('1998', 'Honda Accord', 'white')
MyCar.gas_mileage(12, 431)
puts t_car # => white 1998 Honda Accord
```

3. Why does this code generate an error, and how could you fix it?

```ruby
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

Fixed... the issue is that the `attr_reader` method is a getter method that doesn't have a built-in setter with it. We have to change that if we want to be able to update instance variables for the object.

```ruby
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```