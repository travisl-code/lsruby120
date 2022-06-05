# Fix to produce expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Further Explore - What do you think of this way of creating and initializing Book objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating the steps?

=begin
I believe it makes more sense to initialize the author and title at object instantiation. As discussed in the last exercise, the interesting thing with implementation is that we now have have publicly accessible getter AND setter methods for the title and author. This exposes our data to be changed through the setter methods. In the case of a book, once it's published, the title and author aren't going to change, so it doesn't make sense to have the setter methods UNLESS the data was not validated beforehand.
=end
