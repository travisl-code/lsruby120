# 1) Is the `balance >= 0` line within the `BankAccount#positive_balance?` method ok? Should it have the `@` before?

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

=begin
Ben is right in this example. Because there is a getter method through the line `attr_reader :balance`, invoking `balance` within the `positive_balance` method's body will read the value associated with the `@balance` instance variable.
=end


# 2) Why will the `InvoiceEntry#update_quantity` method fail, and how can you address it?

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

=begin
`quantity` referenced within the `update_quantity` method will not have the expected behavior because it will be treated as a local variable with scope limited to the method itself. It will not update the `@quantity` instance variable. 

There are 2 possible way to address this: 1) change the `update_quantity` method body to `@quantity = updated_count if updated_count >= 0`; or 2) create a setter method for the `@quantity` instance variable and modify the body of the `update_quantity` method to `self.quantity = ...`
=end


# 3) Is there anything wrong with changing the method from the previous exercise to `self.quantity` and changing `attr_reader` to `attr_accessor`.

=begin
I don't necessarily think there's anything wrong with fixing the code this way. However, there may be some unintended consequences of doing it. For example, it would then give outside access to the setter method `quantity=(x)`, which could be a problem (same with the `@product_name` instance variable`). This could be address by making the writer `private` so that it's only callable from within other public methods.
=end


# 4) Create a class `Greeting` with single instance method `greet` that takes a string arg and prints that arg. Then create 2 other classes derived from `Greeting` -- `Hello` (with a `hi` method that takes no args and prints "hello") and `Goodbye` (with a `bye` method to say "Goodbye"). Use the parent class's `greet` method and don't use `puts` within `Hello` or `Goodbye` classes.

class Greeting
  def greet(message)
    puts "#{message}"
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.new.hi
Goodbye.new.bye

=begin
Implemented Hello and Goodbye that inherit from Greeting. The `Greeting#greet` method is invoked from within the respective subclasses to generate the output.
=end


# 5) Write additional code so the `puts` statements work as specified.

class KrispyKreme
  attr_reader :filling_type, :glazing

  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  # Adding code below
  def to_s
    description = ''
    description << (filling_type ? filling_type : 'Plain')
    description << " with #{glazing}" if glazing
    description
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new('Vanilla', nil)
donut3 = KrispyKreme.new(nil, 'sugar')
donut4 = KrispyKreme.new(nil, 'chocolate sprinkles')
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1 # => 'Plain'
puts donut2 # => 'Vanilla'
puts donut3 # => 'Plain with sugar'
puts donut4 # => 'Plain with chocolate sprinkles'
puts donut5 # => 'Custard with icing'

=begin
Without implementing a `to_s` method, the class name and a representation of the object id would be displayed. We build a `to_s` method in the class so that it displays with the correct information.
=end


# 6) What is the difference in the way the code works in these methods in these classes?

class ComputerFirst
  attr_accessor :template

  def create_template
    @template = 'template 14231'
  end

  def show_template
    template
  end
end

class ComputerSecond
  attr_accessor :template

  def create_template
    self.template = 'template 14231'
  end

  def show_template
    self.template
  end
end

=begin
In the `ComputerFirst` class, the `create_template` method assigns the string 'template 14231' to the instance variable `@template` directly without using the setter method that is made available through the line `attr_accessor :template`. The `create_template` method in `ComputerSecond` uses the setter method. This is essentially the same implementation done through 2 different ways, but I believe the preferred method is to use the setter method when it is available.

The 2nd method, `show_template` uses the getter method `template` in both classes. However, there is an unnecessary `self.` in the `ComputerSecond` class. `self` is typically used to disambiguate a local variable from an instance variable.
=end


# 7) How could you change the method name to be more clear and less repetitive?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  # def light_status # original
  def status # new
    "I have a brightness level #{brightness} and a color of #{color}"
  end
end

=begin
Because we're dealing with objects of the Light class, it makes sense that we wouldn't need to include the class name in all the method names as well. This would be redundant.
=end
