class Oystercard

  attr_reader :balance
  MAX_AMOUNT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum amount reached" if amount >= MAX_AMOUNT
    @balance = amount + @balance
  end

  def deducted(fare)
    @balance
    @balance = @balance - fare
  end

  def touch_in
    raise "No balance" if @balance <= MINIMUM
    @in_journey = true
  end

  def touch_out
    @balance = @balance - MINIMUM
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  # def touch_in(barrier)
  #   @cards << card
  # end
  #
  # def touch_out(card)
  #   @cards.delete(card)
  # end
  #
  # def in_journey?(card)
  #   true unless touch_out(card)
  # end
end
