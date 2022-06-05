# Fix program to get expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Further Explore - differences between attr_reader, attr_writer, and attr_accessor? Why use attr_reader? Would it be ok to use one of the others?
=begin
`attr_reader` is just Ruby's shorthand way of defining a getter method; `attr_writer` is shorthand for defining a setter; and `attr_accessor` is shorthand for creating both a getter and setter.

In this code example, it made sense to create the getter only. If we assume that the Book objects are created with valid attributes (that is, the book title and author are correct), there would be no need to have a setter, so `attr_writer` and `attr_accessor` would be unnecessary. However, it may be ok to create the setter methods to be able to modify these values in case of an input error.
=end

# Would the following code have changed the behavior of the class? How so or why not? Any advantages?

# def title
#   @title
# end

# def author
#   @author
# end

=begin
These methods would not have changed the behavior of the program. In fact, using `attr_reader` is the exact same way of creating a getter method; it's just the shorthand version of creating it. In this example, there are no advantages to using this format. However, if any other implementation behaviors were needed, this could offer some benefits. That is, if you wanted to do more than just return the instance variables as they are (e.g. formatting them in some way), then these getters could have some additional benefits.
=end