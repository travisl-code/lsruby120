# Fix to work properly. Assume Customer and Employee classes are complete; just make sure they access the `print_address` method.

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  attr_reader :name, :address, :city, :state, :zipcode
  include Mailable
end

class Employee
  attr_reader :name, :address, :city, :state, :zipcode
  include Mailable
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address
