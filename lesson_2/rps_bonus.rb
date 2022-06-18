require 'pry'
# Game orchestration engine
class RPSGame
  @@games_played = 0
  @@games = {}

  attr_accessor :human, :computer, :score

  def initialize
    @human = Human.new
    @computer = Computer.new
    # @score = Score.new(@human, @computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_moves
    puts "#{human} chose #{human.move}."
    puts "#{computer} chose #{computer.move}."
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must choose y or n."
    end
    answer == 'y'
  end

  def handle_results
    @@games_played += 1
    @@games[@@games_played] = Game.new(human, computer)
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      # display_winner
      handle_results
      # score.display
      break unless play_again?
    end
    display_goodbye_message
  end

  def self.games_played
    @@games_played
  end

  def self.history

  end

end

class Game
  SUBCLASSES = [Rock, Paper, Scissors, Lizard, Spock]
  WIN_CONDITIONS = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['spock', 'paper'],
    'spock' => ['scissors', 'rock']
  }

  attr_reader :winner, :info

  def initialize(human, computer)
    winner = evaluate_winner(human, computer)
    display_winner(winner)
    @winner = winner ? winner.name : 'tie'
    @info = {
      'Player' => human.name,
      'Player Move' => human.move,
      'Computer' => computer.name,
      'Computer Move' => computer.move,
      'winner' => @winner
    }
  end

  def display_winner(winner)
    puts winner ? "#{winner} won!" : "It's a tie!"
  end

  def to_s
    "#{@info['Player']} chose #{@info['Player Move']}; " +
    "#{@info['Computer']} chose #{@info['Computer Move']} (Winner: #{@winner})"
  end

  def evaluate_winner(human, computer)
    if winner?(human, computer)
      human
    elsif winner?(computer, human)
      computer
    else
      nil
    end
  end

  def winner?(player, other_player)
    WIN_CONDITIONS["#{player.move}"].include?("#{other_player.move}")
  end
end

# class Score
#   attr_reader :score, :player_name, :computer_name

#   def initialize(player, computer)
#     @player_name = player
#     @computer_name = computer
#     @score = {@player_name => 0, @computer_name => 0}
#   end

#   def update(winner)
#     return unless winner
#     @score[winner] += 1
#   end

#   def display
#     puts "Current score: #{player_name} has #{score[player_name]} and " +
#     "#{computer_name} has #{score[computer_name]}"
#   end
# end

class Player
  
  attr_accessor :name

  def initialize
    set_name
    available_moves = Move.new
  end

  def to_s
    name
  end

  def move

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
      puts "Please make a selection: #{Move::SUBCLASSES.join(', ')}"
      choice = gets.chomp.capitalize
      break if Move::SUBCLASSES.map(&:to_s).include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Hal', 'WALL-E', 'Chappie', 'R2D2'].sample
  end

  def choose
    self.move = Move.new(Move::SUBCLASSES.sample)
  end
end

class Move
  SUBCLASSES = [Rock, Paper, Scissors, Lizard, Spock]
  # VALUES = Game::WIN_CONDITIONS.keys 

  def initialize(value)
    idx = SUBCLASSES.map(&:to_s).index(value)
    @value = SUBCLASSES[idx].new
    # @value = value 
    # @available_moves = {}
    # SUBCLASSES.each { |move| @available_moves[move.to_s.downcase] move.new }
  end
  
  def to_s
    @value
  end
end

class Rock < Move
end

class Paper < Move
end

class Scissors < Move
end

class Lizard < Move
end

class Spock < Move
end

RPSGame.new.play
