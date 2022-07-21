class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = []
  end

  def check_in(book)
    books.push(book)
  end
end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)

# community_library.books.display_data
community_library.books.each(&:display_data)

=begin
Exception on line 42, when trying to display info about books in library. Determin cause and fix.

The issue with the code is that `@books` is an Array of `Book` objects. When the getter method `Library#books` is called, it returns the `@books` Array. However, the `Book#display_data` method is only available on instances of `Book` objects. That means we either need to iterate through the objects in the `@books` Array, or we need to modify the `display_data` method so that it's available in the `Library` class (and iterates through itself). I chose the first option.
=end
