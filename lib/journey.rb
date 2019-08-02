class Journey

  PENALTY_FARE = 1
  MINIMUM_CHARGE = 1

  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
    @complete_journey = false
    @journeys = []
  end

  def complete?
    @complete_journey
    end

  def fare(fare = PENALTY_FARE)
    if entry_station == nil || exit_station == nil
      fare
    else
      fare = MINIMUM_CHARGE
    end
  end

  def start
    entry_station
  end

  def finish
    exit_station
  end

  def journey_log
    @journeys << { entry_station: @joruney.entry_station, exit_station: @journey.exit_station }
  end

end