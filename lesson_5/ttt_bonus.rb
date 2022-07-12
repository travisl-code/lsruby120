# Tic Tac Toe game

require 'pry'

#####################
# Class definitions #
#####################

# Game Orchestration Engine
class TTTGame
  GAMES_TO_WIN = 2

  attr_reader :board, :human, :computer, :scoreboard

  def initialize(human)
    @human = human
    @players = []
    @players << @human
    set_game_options
    @board = Board.new
    @scoreboard = Scoreboard.new(@human, @computer)
  end

  def play
    main_game
  end

  private

  ## METHODS FOR SETTING GAME OPTIONS

  def set_game_options
    # pick_board_size # Future implementation
    pick_players
    pick_first_move
  end

  # `pick_players` can be modified to have more than 2 players
  def pick_players
    clear
    @computer = Computer.new(@human)
    @players << @computer
  end

  def first_move_valid?(choice)
    (@players.map(&:name) + ['random']).map(&:downcase).include?(choice)
  end

  def process_first_move(choice)
    @players.each do |player|
      if player.name.downcase == choice
        @current_marker = player.marker
      elsif choice == 'random'
        @current_marker = @players.map(&:marker).sample
      end
    end
  end

  def pick_first_move
    choice = nil
    loop do
      puts "\nWho will make the first move? ('#{@human.name}', "\
           "'#{@computer.name}', or 'random')"
      choice = gets.chomp.downcase
      break process_first_move(choice) if first_move_valid?(choice)

      puts "Please make a valid selection."
    end
    choice
  end

  ## METHODS FOR GAME LOOP AND MOVES/TURNS

  def main_game
    loop do
      display_board
      player_move
      handle_result
      break if scoreboard.winner?(GAMES_TO_WIN)

      reset
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      display_board if human_turn?
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def human_moves
    puts "Choose a square: #{board.joinor}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts 'Please make a valid choice.'
    end
    board[square] = human.marker
  end

  def computer_moves
    # `computer_best_move` will return an array of numbers and/or nils
    offense, defense = computer_best_move

    if offense
      board[offense] = computer.marker
    elsif defense
      board[defense] = computer.marker
    else computer_next_best_move
    end
  end

  def computer_best_move
    winnable_square = board.get_winning_square(computer.marker)
    defensive_square = board.get_winning_square(human.marker)
    [winnable_square, defensive_square]
  end

  def computer_next_best_move
    if board.middle_square_unmarked?
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  ## METHODS FOR CONTROLLING BOARD AND ADDITIONAL GAMES

  def clear
    system 'clear'
  end

  def display_board
    clear
    scoreboard.display
    puts ''
    board.draw
    puts ''
  end

  def handle_result
    scoreboard.update(board.winning_marker)
    display_result
  end

  def display_result
    display_board
    case board.winning_marker
    when human.marker then puts 'You won!'
    when computer.marker then puts 'Computer won!'
    else puts 'It\'s a tie!'
    end
    sleep 2
  end

  def reset
    board.reset
    clear
  end
end

# Tracks current game-state
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  # METHODS FOR CREATING, MARKING, AND RESETTING

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new(key) }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  # METHODS FOR PROCESSING BOARD STATE

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3

    markers.min == markers.max
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def get_winning_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      empty_count = squares.map(&:marker).count(Square::INITIAL_MARKER)
      mark_count = squares.map(&:marker).count(marker)
      if empty_count == 1 && mark_count == 2
        empty = squares.select { |sq| sq.marker == Square::INITIAL_MARKER }
        return empty.first.number

      end
    end

    # Tested implementation with sort...

    # WINNING_LINES.each do |line|
    #   squares = @squares.values_at(*line).sort
    #   empty_count = squares.map(&:marker).count(Square::INITIAL_MARKER)
    #   if empty_count == 1 && squares[1].marker == squares[2].marker
    #     empty = squares.select { |sq| sq.marker == Square::INITIAL_MARKER }
    #     return empty.first.number

    #   end
    # end
    nil
  end

  def middle_square_unmarked?
    @squares[5].marker == Square::INITIAL_MARKER
  end

  # METHODS FOR DISPLAYING BOARD AND POSSIBLE MOVES

  def joinor(sep_char = ',', sep_word = 'or')
    available = unmarked_keys
    case available.size
    when 1 then available.first
    when 2 then "#{available.first} #{sep_word} #{available.last}"
    else "#{available[0..-2].join("#{sep_char} ")}" \
         ", #{sep_word} #{available.last}"
    end
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |   #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |   #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |   #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end

# The individual objects that make up the Board
class Square
  INITIAL_MARKER = ' '.freeze

  attr_reader :number
  attr_accessor :marker

  def initialize(num, marker = INITIAL_MARKER)
    @number = num
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  # Future implementation
  # def ==(other_marker)
  #   marker == other_marker
  # end

  # def <=>(other)
  #   marker <=> other.marker
  # end
end

# Definition of Player with unique marker
class Player
  attr_reader :marker, :name

  private

  attr_writer :marker

  def valid?(marker, other_player = nil)
    if other_player
      !marker.nil? && marker.size == 1 && marker != other_player.marker
    else
      !marker.nil? && marker.size == 1 && marker
    end
  end
end

# Definition of Human for name
class Human < Player
  DEFAULT_HUMAN_MARKER = 'X'

  def initialize
    @name = set_name
    @marker = choose_marker
  end

  private

  def set_name
    puts 'What is your name?'
    name = nil
    loop do
      name = gets.chomp
      break if name != ''

      puts 'Please enter a value.'
    end
    name
  end

  def choose_marker
    choice = nil
    puts "\nWhat marker will you use, #{name}? (or type 'default')"
    loop do
      choice = gets.chomp
      choice = (choice.downcase == 'default' ? DEFAULT_HUMAN_MARKER : choice)
      break if valid?(choice)

      puts "Please make a valid choice."
    end
    choice
  end
end

# Definition of Computer
class Computer < Player
  NAMES = ['Hal', 'C3P0', 'WALL-E']
  DEFAULT_COMPUTER_MARKER = 'O'

  def initialize(human_player)
    @name = set_name
    @marker = choose_marker(human_player)
  end

  private

  def set_name
    NAMES.sample
  end

  def choose_marker(human_player)
    choice = nil
    loop do
      puts "\nWhat marker will #{name} use? (or type 'default')"
      choice = gets.chomp
      choice = (choice.downcase == 'default' ? DEFAULT_COMPUTER_MARKER : choice)
      break if valid?(choice, human_player)

      puts "Please make a valid choice."
    end
    choice
  end
end

# Class dependent on Players, used to track and display score
class Scoreboard
  FIXED_WIDTH = 80

  attr_reader :score

  # Attempting to remove dependency by unlinking objects
  # but still need player details for initialization of board
  def initialize(human, computer)
    score = {}
    score[human.marker] = build_score_hash(human)
    score[computer.marker] = build_score_hash(computer)
    @score = score
  end

  def display
    bannerize
    puts ''
  end

  def update(winning_marker)
    score[winning_marker]['wins'] += 1 if winning_marker
  end

  def winner?(games_to_win)
    winning_mark = score.select do |_, details|
      details['wins'] == games_to_win
    end.keys.first
    !!winning_mark
  end

  private

  def build_score_hash(player)
    { 'wins' => 0, 'name' => player.name }
  end

  def bannerize
    puts "+#{'-' * FIXED_WIDTH}+"
    puts "|#{' ' * FIXED_WIDTH}|"
    display_scored_lines
    puts "|#{' ' * FIXED_WIDTH}|"
    puts "+#{'-' * FIXED_WIDTH}+"
  end

  def display_scored_lines
    padding = (FIXED_WIDTH / 2)

    score.each do |marker, details|
      name_and_marker = "#{details['name']} (#{marker})"
      puts "|#{name_and_marker.center(padding)}" \
           "#{details['wins'].to_s.center(padding)}|"
    end
  end
end

############################
# Local method definitions #
############################

def display_welcome_message
  puts "Welcome to Tic Tac Toe! First to #{TTTGame::GAMES_TO_WIN} wins!\n\n"
end

def display_goodbye_message
  puts 'Thanks for playing Tic Tac Toe! Goodbye!'
end

def play_again?
  answer = nil
  loop do
    puts "\nWould you like to play again? (y/n)"
    answer = gets.chomp.downcase
    break if %w(y n).include?(answer)

    puts 'Sorry, must be y or n'
  end
  answer == 'y'
end

#######################
# Main implementation #
#######################

system 'clear'

display_welcome_message

human = Human.new
loop do
  game = TTTGame.new(human)
  game.play
  break unless play_again?
end

display_goodbye_message
