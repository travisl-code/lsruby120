require 'pry'

class InvalidToken < StandardError
  def initialize(name)
    puts "Invalid token: #{name}"
  end
end

class EmptyStack < StandardError
  attr_reader :message
  
  def initialize
    @message = 'Empty stack!'
  end
end

class Minilang
  STACK_OPERATIONS = %w(POP ADD SUB DIV MULT MOD)
  attr_reader :program, :stack, :register, :program_list

  def initialize(program)
    @register = 0
    @stack = []
    @program = program
    @program_list = program.split
  end

  def eval
    begin
      execute(program_list)
    rescue EmptyStack => e
      puts e.message
    rescue InvalidToken
    end
  end

  private

  attr_writer :stack, :register

  def execute(program_array)
    program_array.each do |command|
      if command == 'PUSH' then stack.append(register)
      elsif command == 'PRINT' then puts "#{register}"
      elsif STACK_OPERATIONS.include?(command) then stack_operation(command)
      elsif command.to_i.to_s == command then self.register = command.to_i
      else
        raise InvalidToken.new(command)
      end
    end
  end

  def stack_operation(command)
    raise EmptyStack.new if stack_empty?
    case command
    when 'POP' then self.register = stack.pop
    when 'ADD' then self.register += stack.pop
    when 'SUB' then self.register -= stack.pop
    when 'MULT' then self.register *= stack.pop
    when 'DIV' then self.register /= stack.pop
    when 'MOD' then self.register %= stack.pop
    end
  end

  def stack_empty?
    stack.empty?
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

=begin
Stack and Register problem. Programs supplied through string arg. 
- Produce error if unexpected item in string
- Produce error if required stack value is not on stack (if it's empty)
=end
