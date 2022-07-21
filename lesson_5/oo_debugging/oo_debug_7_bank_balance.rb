require 'pry'

class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    # Commented out
    # if valid_transaction?(new_balance)

    # New if condition to check if the new balance will be valid
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance = amount
      success = true
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  # Commenting out old setter method:
  # def balance=(new_balance)
  #   if valid_transaction?(new_balance)
  #     @balance = new_balance
  #     true
  #   else
  #     false
  #   end
  # end

  # New setter method:
  def balance=(new_balance)
    @balance = new_balance
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

=begin
Program not raising exception but erroneous behavior. Fix behavior.

Problem seems to be with the setter method and with the fact that the validation is happening there. Moved the validation to before the setter is invoked.
=end
