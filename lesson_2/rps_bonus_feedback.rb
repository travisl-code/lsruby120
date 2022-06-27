# rubocop:disable Layout/LineLength
=begin

1. One of the main modifications I've made to this version of the program is that the main menu after each round is no longer there. Now, the game continues through 3 rounds (adjustable), and instead offers the player a choice to play again if desired (no need to relaunch program).

2. The 'quit game' feature is still in the program, but now, it's built as a single note that is prompted that the user can input q or quit to leave the game. This sends a SystemExit error to leave the game.

3. Some error handling has been implemented as well, with begin/end block with rescue clauses.

4. Another major feature is the addition of a scoreboard that will be displayed throughout matches. This is a fixed width box with a simple display. Scores reset after 3-game series, and a (potentially) new computer opponent is selected at random. Game history is displayed still after the series is won; it is also displayed now if the user quits early.

5. A `Displayable` module has been mixed in with some various prompts, most of which are accessed through the game orchestration engine RPSGame class.

=end
# rubocop:enable Layout/LineLength

############################
# Begin Module definitions #
############################

# messages in use throughout game
module Displayable
  # Class methods
  def self.prompt_name
    puts "What's your name?"
  end

  def self.no_input_detected
    puts "Please enter a value."
  end

  def self.welcome
    system 'clear'
    puts "Welcome to #{Game.name}! First to #{RPSGame::GAMES_TO_WIN} wins."
    puts "\n"
    sleep 3
  end

  def self.goodbye
    puts "Thanks for playing #{Game.name}. Goodbye!"
  end

  def self.quit_instructions
    puts "\n"
    puts "Input 'q' or 'quit' to quit the game."
    sleep 3
  end

  def self.exit
    puts "\nYou chose to quit the game. Displaying recent history:"
    puts "\n"
  end

  def self.move_selection
    puts "Please make a selection: #{Game.name}"
  end

  def self.play_again
    puts "Would you like to play again? (y or n)"
  end

  def self.invalid_choice
    puts "Sorry, not a valid choice."
  end

  # Instance methods
  def display_winner
    puts "#{self} won!"
    puts "\n"
  end

  def display_choice(player_object)
    puts "#{player_object.name} chose #{player_object.move}"
  end

  def display_history
    games.each do |game_num, data|
      puts "- Game #{game_num}: #{data}"
    end
    puts "\n"
  end
end

###########################
# Begin Class definitions #
###########################

# Game orchestration engine
class RPSGame
  include Displayable

  GAMES_TO_WIN = 3
  attr_reader :human, :computer, :games, :games_played, :scoreboard

  def initialize(human)
    @computer = Computer.new
    reset_gamestate(human)
    @scoreboard = Scoreboard.new(@human, @computer)
    play
  end

  # Each new game resets win counts and initializes new scores
  def reset_gamestate(human)
    @games_played = 0
    @games = {}
    @human = human
    human.reset_wins
  end

  def new_game
    @games_played += 1
    @games[@games_played] = Game.new(human, computer, scoreboard)
  end

  def overall_winner?
    (human.total_wins >= GAMES_TO_WIN || computer.total_wins >= GAMES_TO_WIN)
  end

  def display_overall_winner
    display_history
    if human.total_wins >= GAMES_TO_WIN
      human.display_winner
    elsif computer.total_wins >= GAMES_TO_WIN
      computer.display_winner
    end
  end

  def handle_overall_winner?
    return false unless overall_winner?
    display_overall_winner
    true
  end

  def handle_exit
    Displayable.exit
    display_history
  end

  # Continue games until winner decided using GAMES_TO_WIN or
  # the player chooses to quit.
  def play
    begin
      loop do
        break if handle_overall_winner?
        new_game
      end
    # When users input 'q' or 'quit' to quit game,
    # SystemExit exception is raised.
    rescue SystemExit
      handle_exit
    end
  end
end

# Game objects tracked individually
class Game
  WIN_CONDITIONS = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['spock', 'paper'],
    'spock' => ['scissors', 'rock']
  }

  # Class variable and class method for name from WIN_CONDITIONS
  @@game_name = WIN_CONDITIONS.keys.join(', ')

  def self.name
    @@game_name
  end

  # Scoreboard displayed; move selections made by Comp and Human;
  # Mooves evaluated by `handle_results`
  def initialize(human, computer, scoreboard)
    scoreboard.display
    human.choose
    computer.choose
    handle_results(human, computer)
  end

  def to_s
    "#{@info['Player']} chose #{@info['Player Move']}; " \
      "#{@info['Computer']} chose #{@info['Computer Move']} " \
      "(Winner: #{@winner})"
  end

  private

  def display_game_winner
    puts "\n"
    puts self
    puts "\n"
    sleep 4
  end

  # handle_results triggers multiple actions, including evaluating
  # the game's winner, updating the `@info` instance variable (for
  # record keeping), and displaying the winner of the round.
  def handle_results(human, computer)
    @winner = evaluate_winner(human, computer)
    @info = {
      'Player' => human.name,
      'Player Move' => human.move,
      'Computer' => computer.name,
      'Computer Move' => computer.move
    }
    display_game_winner
  end

  def evaluate_winner(human, computer)
    if winner?(human, computer)
      human.update_wins
      human.name
    elsif winner?(computer, human)
      computer.update_wins
      computer.name
    else
      'tie'
    end
  end

  def winner?(player, other_player)
    player.move.win_against.include?(other_player.move.to_s)
  end
end

# Parent class for Human and Computer classes
class Player
  include Displayable

  attr_reader :name, :move, :total_wins

  def initialize
    set_name
    @total_wins = 0
  end

  def to_s
    name
  end

  def update_wins
    @total_wins += 1
  end

  def reset_wins
    @total_wins = 0
  end

  private

  attr_writer :name, :move
end

class Human < Player
  def set_name
    n = nil
    loop do
      Displayable.prompt_name
      n = gets.chomp
      break unless n.empty?
      Displayable.no_input_detected
    end
    self.name = n
  end

  # Input validation through the valid_choice? method,
  # followed by normalize_choice method since users can
  # input something like r, ro, roc, or rock for 'rock'
  def choose
    choice = choose_loop
    handle_choice(choice)
  end

  private

  def choose_loop
    loop do
      Displayable.move_selection
      choice = gets.chomp.downcase
      exit if exit_game?(choice)
      if valid_choice?(choice)
        choice = normalize_choice(choice)
        break choice
      end
      Displayable.invalid_choice
    end
  end

  def valid_choice?(choice)
    return false if choice == 's'
    Game::WIN_CONDITIONS.keys.each do |move|
      return true if move.match(/#{choice}/)
    end
    false
  end

  def normalize_choice(choice)
    Game::WIN_CONDITIONS.keys.each do |move|
      choice = move if move.match(/#{choice}/)
    end
    choice
  end

  def exit_game?(choice)
    return true if 'quit'.match(/#{choice}/)
    false
  end

  def handle_choice(choice)
    self.move = case choice
                when 'rock'     then Rock.new
                when 'paper'    then Paper.new
                when 'scissors' then Scissors.new
                when 'lizard'   then Lizard.new
                when 'spock'    then Spock.new
                end
  end
end

# Computer objects will have a 'personality' based on name
class Computer < Player
  def set_name
    self.name = ['Hal', 'WALL-E', 'C3PO'].sample
  end

  def choose
    self.move = case name
                when 'Hal' then personality_im_sorry_dave
                when 'WALL-E' then personality_not_lonely
                when 'C3PO' then personality_translation
                end
  end

  private

  def personality_im_sorry_dave
    sample = rand(100)
    if sample < 60 then Scissors.new
    elsif sample <= 85 then Rock.new
    elsif sample <= 93 then Lizard.new
    else Spock.new
    end
  end

  def personality_not_lonely
    self.move = Lizard.new
  end

  def personality_translation
    sample = rand(100)
    if sample < 50 then Spock.new
    elsif sample < 75 then Lizard.new
    elsif sample < 90 then Paper.new
    elsif sample < 95 then Scissors.new
    else Rock.new
    end
  end
end

# Parent for each individual move class
class Move
  def to_s
    @value
  end

  def win_against
    @win_against = Game::WIN_CONDITIONS[@value]
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end
end

# Scoreboard class is tied to Human and Computer objects;
# only used for score display during game
class Scoreboard
  FIXED_WIDTH = 80
  attr_reader :human, :computer

  def initialize(human, computer)
    @human = human
    @computer = computer
  end

  def display
    system 'clear'
    bannerize
    puts "\n"
  end

  private

  def bannerize
    puts "+#{'-' * FIXED_WIDTH}+"
    puts "|#{' ' * FIXED_WIDTH}|"
    puts scored_line(@human)
    puts scored_line(@computer)
    puts "|#{' ' * FIXED_WIDTH}|"
    puts "+#{'-' * FIXED_WIDTH}+"
  end

  def scored_line(player)
    padding = (FIXED_WIDTH / 2)
    "|#{player.name.center(padding)}#{player.total_wins.to_s.center(padding)}|"
  end
end

############################
# End of Class definitions #
############################

def play_again?
  Displayable.play_again
  choice = nil
  loop do
    choice = gets.chomp.downcase
    break if choice == 'y' || choice == 'n'
    Displayable.invalid_choice
  end
  choice == 'y'
end

# begin/end for main exception handling
begin
  full_game_data = {}
  instances = 0
  Displayable.welcome

  human = Human.new
  Displayable.quit_instructions

  # Main Loop for continuous games
  loop do
    instances += 1
    full_game_data[instances] = RPSGame.new(human)
    break unless play_again?
  end
rescue StandardError => e
  puts e.message
  # puts e.backtrace
ensure
  Displayable.goodbye
end
