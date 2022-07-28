class Student
  def initialize(name, year)
    @name = name
    @year = year
    @parking = nil
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

=begin
Complete `Graduate` and `Undergraduate` `#initialize` details. Graduate students can use on-campus parking, but not Undergrads. Both students have name/year associated with them.

`Student` should be parent class. Main thing is that super needs args specified in Graduate class since it takes a different number of args to initialize.

Further Explore - super() can be called.
Could create a class of students that don't have a year or name. Something like `Prospect` maybe, so there is no identifying information.
=end
