class Oystercard

  attr_reader :balance, :entry_barrier, :journey_history
  MAX_AMOUNT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_barrier = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum amount reached" if amount >= MAX_AMOUNT
    @balance = amount + @balance
  end

  def deducted(fare)
    @balance
    @balance = @balance - fare
  end

  def touch_in(barriers)
    raise "No balance" if @balance <= MINIMUM
    @entry_barrier = barriers
  end

  def touch_out(exit_barrier)
    @balance = @balance - MINIMUM
    @journey_history << { @entry_barrier => exit_barrier }
    @entry_barrier = nil
  end

  def in_journey?
    if @entry_barrier == nil
      false
    else
      true
    end
  end
end
