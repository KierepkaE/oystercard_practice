require_relative 'journey'

class Oystercard
  attr_reader :balance, :journeys, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if @balance < MINIMUM_BALANCE
    @journey.entry_station = station
  end

  def touch_out(station)
    deduct(@journey.fare)
    @journey.exit_station = station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
