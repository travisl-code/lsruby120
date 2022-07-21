class EmployeeManagementSystem
  attr_reader :employer

  def initialize(employer)
    @employer = employer
    @employees = []
  end

  def add(employee)
    if exists?(employee)
      puts "Employee serial number is already in the system."
    else
      employees.push(employee)
      puts "Employee added."
    end
  end

  alias_method :<<, :add

  def remove(employee)
    if !exists?(employee)
      puts "Employee serial number is not in the system."
    else
      employees.delete(employee)
      puts "Employee deleted."
    end
  end

  def exists?(employee)
    employees.any? { |e| e == employee }
  end

  def display_all_employees
    puts "#{employer} Employees: "

    employees.each do |employee|
      puts ""
      puts employee.to_s
    end
  end

  private

  attr_accessor :employees
end

class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  private

  # Commented out this line, which was the incorrect one.
  # attr_reader :serial_number

  def abbreviated_serial_number
    serial_number[-4..-1]
  end

  # Added the `protected` method and moved the serial_number getter there
  protected

  attr_reader :serial_number
end

# Example

miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

becca = Employee.new('Becca', '232-4437-1932')
raul = Employee.new('Raul', '399-1007-4242')
natasha = Employee.new('Natasha', '399-1007-4242')

miller_contracting << becca     # => Employee added.
miller_contracting << raul      # => Employee added.
miller_contracting << raul      # => Employee serial number is already in the system.
miller_contracting << natasha   # => Employee serial number is already in the system.
miller_contracting.remove(raul) # => Employee deleted.
miller_contracting.add(natasha) # => Employee added.

miller_contracting.display_all_employees

=begin
Code gives error; fix so it works as expected.

The exception was being called in the `EmployeeManagementSystem#<<` method. This method is an alias for the `#add` method (new syntax I haven't seen). `add` then invokes the `exists?` method, which iterates through the `@employees` array (each object in the array is an Employee instance), and `exists` calls the `Employee#==` method. We're finally at the stack level where the exception is raised. Inside `==`, the `serial_number` method is invoked to compare the serial numbers of one object to another. However, the `attr_reader :serial_number` line was declared as a `private` method. This doesn't work because you can't pass multiple object instances into a `private` method. Instead, you have to use a `protected` method. I created the `protected` method access control and move `serial_number` to it and the code ran as expected.
=end
