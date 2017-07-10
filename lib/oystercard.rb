class Oystercard

  attr_reader :balance
  MAX_AMOUNT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum amount reached" if amount >= MAX_AMOUNT
    amount + @balance
  end

end
