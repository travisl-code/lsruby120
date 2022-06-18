# Game orchestration engine
class RPSGame
  WIN_CONDITIONS = {
    'rock' => ['scissors'],
    'paper' => ['rock'],
    'scissors' => ['paper']
  }

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "The #{computer.name} chose #{computer.move}."
    if winner?(human, computer)
      puts "#{human.name} won!"
    elsif winner?(computer, human)
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def winner?(player, other_player)
    WIN_CONDITIONS[player.move].include?(other_player.move)
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp.downcase
      break if ['rock', 'paper', 'scissors'].include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['Hal', 'WALL-E', 'Chappie', 'R2D2'].sample
  end

  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
end

# class Move
#   VALUES = ['rock', 'paper', 'scissors']

#   def initialize(value)
#     @value = value
#   end
# end

# class Rule
#   def initialize
#   end
# end

RPSGame.new.play
