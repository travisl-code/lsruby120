# Twenty-One Game

require 'pry'

############################
# BEGIN MODULE DEFINITIONS #
############################

# General purpose display methods for various parts of game
module DisplayGeneral
  # CLASS METHOD DEFINITIONS
  def self.welcome
    system 'clear'
    puts "Welcome to Twenty-One!"
  end

  def self.goodbye
    puts "\nThanks for playing Twenty-One!"
  end

  def self.what_is_your_name
    puts "\nWhat is your name?"
  end

  def self.how_many_players
    puts "\nHow many players in addition to you and the dealer?"
  end

  def self.hit_or_stay_message
    puts "\nWould you like to hit ('hit' or 'h') or stay ('stay' or 's')?"
  end

  def self.not_valid
    puts "\nPlease enter a valid value."
  end

  def self.play_again
    puts "\nWould you like to play again? (yes or no)"
  end

  def dealer_welcome
    puts "\n#{name} will be the dealer this game"
    sleep 2
  end

  def display_winners(winners_string)
    puts "\nWinner: #{winners_string}"
  end
end

# Module for various displays of cards in hand
module DisplayHand
  BUST_DISPLAY = 'BUST'

  # INSTANCE METHOD DEFINITIONS
  def display_first_cards
    if Dealer == self.class
      puts "#{name} has: #{hand.first} and one unknown card "\
           "(Visible Total: #{visible_total})"
    elsif Human == self.class
      puts "#{name} has: #{join_cards(hand)} (Total: #{total})"
    else
      puts "#{name} has: #{hand.size} unknown cards"
    end
  end

  def display_cards(verb = 'has')
    displayable = total
    displayable = (total >= self.class::BUST ? BUST_DISPLAY : displayable)
    puts "#{name} #{verb}: #{join_cards(hand)} (Total: #{displayable})"
  end

  def display_hit(new_cards)
    puts "\n#{name} hits! Adding to hand: #{join_cards(new_cards)}"
    sleep 1
  end

  def display_stay
    puts "\n#{name} stays."
    puts ''
    sleep 1
  end

  def display_bust
    puts "\n#{name} busts!"
    puts ''
    sleep 2
  end

  private

  # Configured to be able to display single cards for hitting
  def join_cards(cards)
    case cards.size
    when 1 then cards.first.to_s
    when 2 then "#{cards.first} and #{cards.last}"
    else "#{cards[0..-2].join(', ')}, and #{cards.last}"
    end
  end
end

# Hand module for methods related to cards in hand
module Hand
  include DisplayHand

  BUST = 22

  attr_accessor :hand

  # An Array is passed into the `hit` method
  def hit(new_cards)
    display_hit(new_cards)
    @hand += new_cards
  end

  def stay
    display_stay
  end

  def busted?
    total >= BUST
  end

  def total
    total = hand.map(&:value).sum
    if total >= BUST && ace_to_reset?
      reset_ace_value
      total = hand.reduce(0) { |memo, card| memo + card.value }
    end
    total
  end

  private

  def ace_to_reset?
    hand.any?(&:ace_high?)
  end

  def reset_ace_value
    high_ace = hand.select(&:ace_high?).first
    high_ace.update_ace_value!(self.class)
  end
end

###########################
# BEGIN CLASS DEFINITIONS #
###########################

# Player class is super for Human, Dealer, and future Computer
class Player
  include Hand, DisplayGeneral

  DEALER_TARGET = 17

  attr_reader :name

  def initialize
    self.hand = []
    set_name
  end

  def to_s
    name
  end

  def dealer?
    self.class == Dealer
  end

  def computer?
    self.class == Computer
  end

  # Since dealer goes last, they see the scores of other players
  def evaluate_hit_or_stay(high_points = 0)
    if total <= high_points && total < DEALER_TARGET
      return 'hit'
    end
    'stay'
  end
end

# Human class is unique to human player
class Human < Player
  def evaluate_hit_or_stay(_high_score = 0)
    choice = nil
    DisplayGeneral.hit_or_stay_message
    loop do
      choice = gets.chomp.downcase
      break if valid_choice?(choice)

      DisplayGeneral.not_valid
    end
    choice
  end

  private

  def set_name
    name = nil
    DisplayGeneral.what_is_your_name

    loop do
      name = gets.chomp
      break if valid_name?(name)

      DisplayGeneral.not_valid
    end
    @name = name
  end

  def valid_name?(name)
    name != ''
  end

  def valid_choice?(choice)
    !!'hit'.match(choice) || !!'stay'.match(choice)
  end
end

# Dealer has natural advantage of only showing 1 card (default)
# and taking their turn last -- Dealer knows total to beat.
class Dealer < Player
  VISIBLE_CARDS = 1
  DEALER_NAMES = ['Stu', 'Ali', 'Ryne', 'Bruce', 'Matt']

  def initialize
    super
    dealer_welcome
  end

  def visible_total
    hand.first(VISIBLE_CARDS).map(&:value).sum
  end

  private

  def set_name
    @name = DEALER_NAMES.sample
  end
end

class Computer < Player
  @@computers = 0

  def initialize
    @@computers += 1
    super
  end

  def set_name
    @name = "Computer#{@@computers}"
  end
end

# Deck is 52 Cards: 4 suits and 13 cards per suit
class Deck
  STARTING_CARDS = 2
  SUITS = ['Hearts', 'Spades', 'Diamonds', 'Clubs']
  SPECIALS = ['Jack', 'Queen', 'King']
  ACE = 'Ace'
  VALUES = ('2'..'9').to_a + SPECIALS + [ACE]

  attr_reader :cards

  def initialize
    make_deck
  end

  def deal(count = STARTING_CARDS)
    @cards.pop(count)
  end

  private

  def make_deck
    deck = []
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << Card.new(suit, value)
      end
    end
    @cards = deck.shuffle
  end
end

# Individual Cards make up the deck
class Card
  ACE_HIGH = 11
  ACE_LOW = 1
  FACE_CARD_VALUE = 10

  attr_reader :suit, :value, :name

  def initialize(suit, value)
    @suit = suit
    @name = value
    @value = evaluate_value
  end

  def to_s
    "#{name} of #{suit}"
  end

  def ace_high?
    name == Deck::ACE && value == ACE_HIGH
  end

  def update_ace_value!(calling_class = nil)
    self.value = ACE_LOW if calling_class && ace_high?
  end

  private

  attr_writer :value

  def evaluate_value
    if name == name.to_i.to_s
      name.to_i
    elsif Deck::SPECIALS.include?(name)
      FACE_CARD_VALUE
    else
      ACE_HIGH
    end
  end
end

# Score class is useful for players to see in a rolling fashion
# which points are visible as players show cards
class Score
  attr_reader :result

  def initialize(players)
    score = {}
    players.each do |player|
      score[player.name] = { 'points' => 0 }
    end

    @result = score
  end

  def update_points(player, points)
    @result[player]['points'] = points
  end

  def current_highest_points
    result.map do |_, details|
      details['points']
    end.max
  end

  def winner
    high = current_highest_points
    winners = result.select do |_, details|
      details['points'] == high
    end.keys
    join_winners(winners)
  end

  private

  def join_winners(winner_array)
    case winner_array.size
    when 1 then winner_array.first
    when 2 then "#{winner_array.first} and #{winner_array.last}"
    else "#{winner_array[0..-2].join(', ')}, and #{winner_array.last}"
    end
  end
end

# Game orchestration engine
class Game
  include DisplayGeneral

  HIT_CARDS = 1

  def initialize(human)
    @players = []
    @human = human
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    game_state
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  private

  attr_reader :players, :human, :dealer, :deck, :score

  def game_state
    @players << @dealer
    @players << human
    addtl_players = number_of_players
    @players += make_players(addtl_players)
    @score = Score.new(@players)
  end

  def number_of_players
    DisplayGeneral.how_many_players
    choice = nil
    loop do
      choice = gets.chomp
      break if valid?(choice)

      DisplayGeneral.not_valid
    end
    choice.to_i
  end

  def valid?(choice)
    choice.to_i.to_s == choice
  end

  def make_players(number)
    additional_players = []
    number.times { additional_players << Computer.new }
    additional_players
  end

  def deal_cards
    players.each { |player| player.hand = deck.deal }
  end

  def show_initial_cards
    system 'clear'

    players.each(&:display_first_cards)
  end

  def player_turn
    players.each do |player|
      next if player.dealer?

      main_player_loop(player)
      score.update_points(player.name, player.total) unless player.busted?
    end
  end

  def dealer_turn
    dealer = players.select(&:dealer?).first
    high_score = score.current_highest_points

    main_player_loop(dealer, high_score)
    score.update_points(dealer.name, dealer.total) unless dealer.busted?
  end

  def main_player_loop(player, high_score = 0)
    loop do
      high_score = score.current_highest_points
      binding.pry
      break player.display_bust if player.busted?

      choice = player.evaluate_hit_or_stay(high_score)
      break player.stay if 'stay'.match(choice)

      handle_hit(player)
    end
  end

  def handle_hit(player)
    player.hit(deck.deal(HIT_CARDS))
    player.display_cards
  end

  def show_result
    players.each { |player| player.display_cards('ends with') }
    display_winners(score.winner)
  end
end

##################################
# BEGIN LOCAL METHOD DEFINITIONS #
##################################

class BasicGame
  include DisplayGeneral

  attr_reader :human

  def initialize
    DisplayGeneral.welcome
    @human = Human.new
    play
    DisplayGeneral.goodbye
  end

  def play
    loop do
      game = Game.new(human)
      game.start
      break unless play_again?
    end
  end

  def play_again?
    DisplayGeneral.play_again
    choice = nil
  
    loop do
      choice = gets.chomp.downcase
      break if valid?(choice)
  
      DisplayGeneral.not_valid
    end
  
    !!'yes'.match(choice)
  end
  
  def valid?(choice)
    !!('yes'.match(choice) || 'no'.match(choice))
  end
end

#############################
# BEGIN MAIN IMPLEMENTATION #
#############################

BasicGame.new
