class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  # Adding `==` method
  def ==(other)
    self.to_s == other.to_s
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

=begin
Lines 37 and 38 are at same coordinates, so why does 39 output false? Fix to produce expected output.

The problem with this code is that the `Person#location` getter method refers to an object (it's a collaborator object). Therefore, the default `==` method is comparing to see if the objects are the same, but they're not. We have to override the `==` method by defining a new one in the `GeoLocation` class, so that Ruby knows how to compare those objects with each other.
=end