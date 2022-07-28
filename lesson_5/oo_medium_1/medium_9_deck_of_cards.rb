require 'pry'

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :cards

  def initialize
    make_deck
  end

  def draw
    make_deck if cards.empty?
    cards.pop
  end

  private

  def make_deck
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank, suit)
      end
    end
    @cards = cards.shuffle
  end
end

class Card
  include Comparable

  RANKS_ORDER = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    value = (rank.is_a?(String) ? RANKS_ORDER[rank] : rank)
    other_value = (other.rank.is_a?(String) ? RANKS_ORDER[other.rank] : other.rank)
    value <=> other_value
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }

puts (drawn.count { |card| card.rank == 5 } == 4) # true
puts (drawn.count { |card| card.suit == 'Hearts' } == 13) # true
puts drawn.size == 52 # true

drawn2 = []
52.times { drawn2 << deck.draw }
drawn != drawn2 # Almost always.

=begin
Create deck class that shuffles at initialization.
=end
