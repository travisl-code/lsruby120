# Modify this code so it works. Don't make the amount in wallet accessible to any method not part of Wallet class

class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected
  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# Further Explore - applications where protected methods would be desirable?

=begin
I could see a similar usage being implemented where there's a public method that requires authentication, which then allows you to see the contents of the wallet (or bank account or whatever), but this would be implemented with a private getter, not public; the comparison of accounts thing could then be protected. If you have a checking account, you may want to move funds to a savings account, or vice versa. There would be publicly exposed behaviors allowing the 2 objects to interact.
=end
