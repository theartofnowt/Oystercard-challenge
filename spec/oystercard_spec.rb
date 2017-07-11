require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }

  it "tests that an initialized card has balance of 0" do
    expect(oystercard.balance).to be 0
  end

  it "test that the card has been topped up?" do
    expect(oystercard).to respond_to :top_up
  end

  it "test if the maximum amount is reached" do
    expect { oystercard.top_up(Oystercard::MAX_AMOUNT) }.to raise_error("Maximum amount reached")
  end

  it "test if fare has been deducted from card" do
    expect(oystercard).to respond_to :deducted
    oystercard.top_up(89)
    expect(oystercard.deducted(2)).to eq 87
  end

  describe "journeys" do
    it "responds to the touch_in method" do
      expect(oystercard).to respond_to :touch_in
    end

    it "responds to the touch_out method" do
      expect(oystercard).to respond_to :touch_out
    end

    it "in_journey? returns true after touching in" do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
  end
end
