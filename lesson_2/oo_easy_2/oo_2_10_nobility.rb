# Expand Walkable module to include new Noble class's title:

# byron = Noble.new("Byron", "Lord")
# byron.walk
# # => "Lord Byron struts forward"

module Walkable
  def walk
    puts "#{self} #{gait} forward."
  end
end

class Noble
  include Walkable

  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private
  def gait
    "struts"
  end
end

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

# Further Explore - This exercise can be solved in a similar manner by using inheritance; a Noble is a Person, and a Cheetah is a Cat, and both Persons and Cats are Animals. What changes would you need to make to this program to establish these relationships and eliminate the two duplicated #to_s methods?

=begin
The main change, of course, would be the setting of the inheritance (`class Nobility < Person`). This would also require using `super(name)` to initialize variables through the superclass and keep `@title` in the Noble class. Then, you'd just need the `to_s` method on the parent, and you could override if it needed for classes like Noble.

=end

# Is to_s the best way to provide the name and title functionality we needed for this exercise? Might it be better to create either a different name method (or say a new full_name method) that automatically accesses @title and @name? There are tradeoffs with each choice -- they are worth considering.

=begin
I did not think this was a very functional way to handle this. It would have made more sense to me to be able to have access to a `formal_name` and `informal_name` method, or something similar. That way, when needed, the non-titled name can be used.
=end