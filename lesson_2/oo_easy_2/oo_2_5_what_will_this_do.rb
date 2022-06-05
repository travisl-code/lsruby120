# What will this code print?

=begin
ByeBye
HelloHello

New Something object initialized and stored in local variable `thing`. This creates an instance variable `@data`, which references a string object `Hello`. The class method `Something#dupdata` is invoked, which returns the string `ByeBye`, which is passed to `puts` and output. Then the instance method `dupdata` is invoked on the `thing` calling object, which returns the instance variable @data (`Hello` value) twice, which gets output by `puts`.
=end

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata