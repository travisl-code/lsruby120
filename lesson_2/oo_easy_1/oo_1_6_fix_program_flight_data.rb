# How to fix to be resistant to future problems?

=begin
Remove the read/write for @database_handle
=end

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end