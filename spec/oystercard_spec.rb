require "./lib/oystercard"

describe Oystercard do
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

  # it "stores a journey" do
  #   subject.top_up(Oystercard::MINIMUM_BALANCE)
  #   subject.touch_in(entry_station)
  #   subject.touch_out(exit_station)
  #   expect(subject.journeys).to include journey
  # end

  # it "stores exit station" do
  #   subject.top_up(Oystercard::MINIMUM_BALANCE)
  #   subject.touch_in(entry_station)
  #   subject.touch_out(exit_station)
  #   expect(subject.exit_station).to eq exit_station
  # end

  # it "stores the entry station" do
  #   subject.top_up(Oystercard::MINIMUM_BALANCE)
  #   subject.touch_in(station)
  #   expect(subject.entry_station).to eq(station)
  # end

  it "has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "tops up the balance" do
      expect { subject.top_up(1) }.to change { subject.balance }.by (1)
    end

    it "raises an error if the maximum balance is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe "#deduct" do
    it { is_expected.to respond_to(:deduct).with(1).argument }
  end

  it "deducts an amount from the balance" do
    subject.top_up(20)
    expect { subject.deduct(5) }.to change { subject.balance }.by (-5)
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  it "can touch in" do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it "can touch out" do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject).not_to be_in_journey
  end

  it "will not touch in if below minimum balance" do
    expect { subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
  end

  it "will deduct the minimum charge from balance" do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(station)
    expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
  end

  it "has an empty list of journeys by default" do
    expect(subject.journeys).to be_empty
  end
end
