# Update to see this when running code:

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

class Pet
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :color

  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Further Explore - could have modifed pet class's initialize method to accept color parameter. Why would we be able to omit initialize method? Would this be a good idea? How might you deal with problems of modifying Pet?

=begin
We would have been able to omit the Cat#initialize method if we set the Pet#initialize to accept a `color` parameter because the 3rd argument is what made us set Cat differently (the inherited superclass Pet took a different number of parameters in its init method). 

I think this may have been a good idea to modify the Pet class this way instead of the subclass. Color isn't an attribute that's unique to cats, so any Pet could have a defined color. 

The only problem I see is that if you had objects created before modifying the Pet class, they wouldn't have that attribute. There'd have to be some way to update all existing objects to have that new attribute.
=end
