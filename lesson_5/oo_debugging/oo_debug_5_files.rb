class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    # Commenting out because this is the problem line
    # "#{name}.#{FORMAT}"

    # Modified:
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

=begin
Uninitialized constant File::FORMAT error. What is problem, and what could be done to fix?

The problem here is when Line 49 is invoked `puts blog_post`. The local variable `blog_post` is passed to `puts`, which invokes the `to_s` method on the argument automatically to display it. `to_s` is overridden in the `File` class and, since constants are lexically scoped, Ruby searches for the `FORMAT` constant in the `File` class, and it's not defined there. In fact, `blog_post` is actually an object of class `MarkdownFile`, not `File` (which it inherits from). This leads us to one of the better solutions... if we reference `self` in a method in `File`, it will refer to an instance of self as the subclass the object actually belongs to. If we invoke `self.class`, it then shows the class it belongs to. We can use this to combine that method invocation with `::` for namespacing as `self.class::FORMAT` and the object will reference itself, then its class, and finally search the lexical scope of that class for the `FORMAT` constant.

Another possible solution would be to define a default `FORMAT` constant, or even a method that returns the `FORMAT` constant in the way we did above.
=end
