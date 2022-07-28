class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def state
    "The switch is #{switch}"
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

=begin
Modify so `flip_switch` and `switch=` are private.

Defined the private access control and moved the writer to private. 

Further Explore -- Add private getter for `@switch` state
=end
