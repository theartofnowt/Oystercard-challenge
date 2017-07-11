require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }
  let(:barriers) { double('barriers') }

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
      expect(oystercard).to respond_to(:touch_in).with(1).argument
    end

    it "responds to the touch_out method" do
      expect(oystercard).to respond_to :touch_out
    end

    it "in_journey? returns true after touching in" do
      oystercard.top_up(56)
      oystercard.touch_in(barriers)
      expect(oystercard).to be_in_journey
    end

    it "should raise an error if there is no balance on card" do
      oystercard = Oystercard.new
      expect{ oystercard.touch_in(barriers) }.to raise_error("No balance")
    end

    it "will deduct my balance by the minimum fare after touching out" do
      oystercard.top_up(5)
      oystercard.touch_in(barriers)
      expect { oystercard.touch_out }.to change { oystercard.balance } .by(-1)
    end

    it "will remember the station when card touched in" do
      oystercard.top_up(5)
      oystercard.touch_in(barriers)
      expect{ oystercard.touch_in(barriers)}
    end

    it "will forget the station when touched out" do
      oystercard.top_up(5)
      oystercard.touch_in(barriers)
      oystercard.touch_out
      expect(oystercard.entry_barrier).to be nil

    end

  end
end
