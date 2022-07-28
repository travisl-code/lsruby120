class GuessingGame
  GUESSES = 7

  attr_reader :guesses_left

  def initialize
    @number = rand(1..100).to_s
    @guesses_left = GUESSES
    @win = false
  end

  def play
    until guesses_left == 0
      puts "\nYou have #{guesses_left} guesses remaining."
      print "Enter a number between 1 and 100: "
      guess = gets.chomp
      evaluate(guess) if valid?(guess)
      break if game_won?

      self.guesses_left -= 1
    end
    game_won? ? you_win : you_lose
  end

  private

  attr_reader :number, :win
  attr_writer :win, :guesses_left

  def game_won?
    win
  end

  def evaluate(guess)
    case guess <=> number
    when -1 then puts "Your guess is too low."
    when 0 then self.win = true
    when 1 then puts "Your guess is too high."
    end
  end

  def valid?(guess)
    !!guess.match(/[0-9]+/)
  end

  def you_win
    puts "\nThat's the number!"
  end

  def you_lose
    puts "\nYou have no more guesses. You lost! Number was #{number}"
  end
end

game = GuessingGame.new
game.play

=begin
Create number guessing game that should work like this:
s

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!


=end
