=begin
1. I first built this as a Score class for practice, and wound up asking about it Slack. It seemed unnecessary as a standalone class though because there was more data passed than needed to be. Instead, I implemented a `@total_wins` instance variable for each Player object and evaluated that after each round.

2. Added Lizard and Spock choices, but I didn't really care for the `<` and `>` methods that were originally used. I changed this functionality and built the evaluation of all choices into the `Game::WIN_CONDITIONS` hash.

3. Adding an individual class for all the move options (Rock, Paper, Scissors, Lizard, Spock) was really difficult. I feel like it was a challenge to think about OOP principles, but I thought about this and refactored code for a full week without finding a good way to do it. I do not think it was a good design decision, at least with the way I wound up choosing. The instances don't have their state change, and there are no behaviors that are unique to the individual classes. I finally just coded something to have this in place, but I'm not happy with the result, and even after substantial effort, I don't see how this could be implemented in a useful way.

4. I liked this addition, but it required a signifcant amount of refactoring. I created the Game class (it may be better as NewGame), and each new game tracks its own data. The history of games is tracked through a simple hash where I increment `@games_played` by 1 each time and use that as the hash key, and then store all the Game instance data as the hash value. This would even allow a future implementation of a new menu item where you could specify which game you wanted to see the history of.

5. For the computer personalities, I don't think I had a very solid way of doing this. It made the most sense at the time to build this as part of the Computer class because that's where the `@name` instance variable is. I suppose I could have built personalities as individual classes and instantiated a personality after the name was chosen at random. I just used a simple random number to help generate the choices.
=end

require 'pry'

# Game orchestration engine
class RPSGame
  GAMES_TO_WIN = 5
  attr_reader :human, :computer, :games, :games_played

  def initialize
    system 'clear'
    @games_played = 0
    @games = {}
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    system 'clear'
    puts "Welcome to #{Game.name}! First to #{GAMES_TO_WIN} wins."
    sleep 3
  end

  def display_goodbye_message
    puts "Thanks for playing #{Game.name}. Goodbye!"
  end

  def new_game
    @games_played += 1
    @games[@games_played] = Game.new(human, computer)
  end

  def history
    @games.each do |game_num, data|
      puts "Game #{game_num}: #{data}"
    end
    puts "\n"
  end

  def menu(choice)
    loop do
      puts "Please choose a number to make a selection:"
      puts "1. Play a game"
      puts "2. View game history"
      puts "3. Quit game"
      choice = gets.chomp
      break if %w(1 2 3).include?(choice)
      puts "Please make a valid choice."
    end
    system 'clear'
    choice
  end

  def overall_winner?
    (human.total_wins >= GAMES_TO_WIN || computer.total_wins >= GAMES_TO_WIN)
  end

  def display_overall_winner
    system 'clear'
    history
    puts "\n"
    puts "#{human.name} won!" if human.total_wins >= GAMES_TO_WIN
    puts "#{computer.name} won!" if computer.total_wins >= GAMES_TO_WIN
  end

  def play
    display_welcome_message
    new_game
    loop do
      if overall_winner?
        display_overall_winner
        break
      end
      choice = nil
      choice = menu(choice)
      case choice
      when '1' then new_game
      when '2' then history
      when '3' then break
      end
    end
    display_goodbye_message
  end
end

class Game
  WIN_CONDITIONS = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['spock', 'paper'],
    'spock' => ['scissors', 'rock']
  }

  @@game_name = "#{WIN_CONDITIONS.keys.join(', ')}"

  def initialize(human, computer)
    system 'clear'
    human.choose
    computer.choose
    handle_results(human, computer)
  end

  def to_s
    "#{@info['Player']} chose #{@info['Player Move']}; " +
    "#{@info['Computer']} chose #{@info['Computer Move']} (Winner: #{@winner})"
  end

  private
  def display_winner
    system 'clear'
    puts self
    puts "\n"
  end

  def handle_results(human, computer)
    @winner = evaluate_winner(human, computer)
    @info = {
      'Player' => human.name,
      'Player Move' => human.move,
      'Computer' => computer.name,
      'Computer Move' => computer.move
    }
    display_winner
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
    player.move.win_against.include?("#{other_player.move}")
  end

  def self.name
    @@game_name
  end
end

class Player
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

  private
  attr_writer :name, :move
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
      puts "Please make a selection: #{Game.name}"
      choice = gets.chomp.downcase
      break if Game::WIN_CONDITIONS.keys.include?(choice)
      puts "Sorry, invalid choice."
    end
    handle_choice(choice)
  end

  private
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
    case
    when sample < 60 then Scissors.new
    when sample <= 85 then Rock.new
    when sample <= 93 then Lizard.new
    else Spock.new
    end
  end

  def personality_not_lonely
    self.move = Lizard.new
  end

  def personality_translation
    sample = rand(100)
    case
    when sample < 50 then Spock.new
    when sample < 75 then Lizard.new
    when sample < 90 then Paper.new
    when sample < 95 then Scissors.new
    else Rock.new
    end
  end
end

class Move
  attr_reader :win_against
  
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

RPSGame.new.play
