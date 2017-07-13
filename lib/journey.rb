class Journey

  attr_reader :starting_station, :end_station, :in_journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(starting_station = nil, exit_station = nil)
    @starting_station = starting_station
    @end_station = exit_station
    @in_journey = true
  end

  def finish end_station
    @end_station = end_station
    @in_journey = false
  end

  def fare
    if @end_station == nil || @starting_station == nil
      puts "charged penalty"
      PENALTY_FARE
    else
      puts "charged fare"
      MINIMUM_FARE
    end
  end

end
