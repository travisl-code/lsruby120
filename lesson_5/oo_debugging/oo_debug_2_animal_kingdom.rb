class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    # super
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

=begin
Code above throws error. Find and fix

Looked through before running, and the SongBird subclass takes 3 args but calls `super`, which only takes 2 args. Need to specify which args get passed to `super` since they don't match.

FURTHER EXPLORE - is `FlightlessBird#initialize` method necessary?
In its current state, this initialize is not needed. It takes the same number of arguments as the superclass, and all it does is call `super`. It has the exact same behavior as the `Animal#initialize` method.
=end