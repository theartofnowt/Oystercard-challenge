class Oystercard

  attr_reader :balance, :journey_history
  MAX_AMOUNT = 90


  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum amount reached" if amount >= MAX_AMOUNT
    @balance = amount + @balance
  end

  def touch_in(entry_station)
    raise "No balance" if @balance <= Journey::MINIMUM_FARE
    if in_journey?
      deduct_fare
    else
      create_journey(entry_station)
    end
  end

  def touch_out(exit_station)
    if !in_journey?
      create_journey(nil, exit_station)
    else
      @journey_history.last.finish(exit_station)
    end
    deduct_fare
  end

  def in_journey?
    return false if @journey_history.empty?
    @journey_history.last.in_journey
  end

  private

  def deduct_fare
    @balance -= @journey_history.last.fare
  end

  def create_journey(entry_station = nil, exit_station = nil)
    @journey_history << Journey.new(entry_station, exit_station)
  end
end
