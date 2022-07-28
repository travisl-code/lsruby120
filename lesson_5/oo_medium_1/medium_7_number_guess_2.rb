require 'pry'

class GuessingGame
  WIN_MSG = { 'win' => 'You won!',
              'lose' => 'You have no more guesses. You lost!' }
  GUESS_MSG = { 'high' => 'Your guess is too high.',
                'low' => 'Your guess is too low.' }

  attr_reader :range, :default_guesses, :guesses

  def initialize(low, high)
    @range = (low..high)
    size_of_range = range.size
    @default_guesses = Math.log2(size_of_range).to_i + 1
  end

  def play
    loop do
      reset
      game_loop
      display_result
      break unless play_again?
    end
  end

  private

  attr_reader :number, :choice
  attr_writer :number, :guesses, :choice

  def reset
    system 'clear'
    self.choice = nil
    self.number = range.to_a.sample
    self.guesses = default_guesses
  end

  def display_result
    puts (number_guessed? ? WIN_MSG['win'] : WIN_MSG['lose'])
  end

  def display_select
    puts "\nYou have #{guesses} remaining..."
    print "Enter a number between #{range.first} and #{range.last}: "
  end

  def play_again?
    puts "\nWould you like to play again? (yes or no)"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(yes no y n).include?(answer)

      puts 'Please make a valid choice'
    end
    return true if answer == 'yes' || answer == 'y'
    false
  end

  def game_loop
    until guesses == 0 do
      display_select
      answer = gets.chomp
      handle(answer)
      break if number_guessed?

      self.guesses -= 1
    end
  end

  def handle(answer)
    if valid?(answer)
      self.choice = answer.to_i
      high_or_low
    else
      puts "Invalid guess."
    end
  end

  def high_or_low
    case choice <=> number
    when -1 then puts GUESS_MSG['low']
    when 0 then return
    when 1 then puts GUESS_MSG['high']
    end
  end

  def valid?(answer)
    range.cover?(answer.to_i)
  end

  def number_guessed?
    choice == number
  end
end

game = GuessingGame.new(501, 1500)
game.play

=begin
Update number guess game to accept low and high values to compute secret number.
- Set number of guesses with this:
Math.log2(size_of_range).to_i + 1


=end
