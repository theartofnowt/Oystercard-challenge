require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }
  let(:barriers) { double('barriers') }
  let(:amount) { 5 }

  it "tests that an initialized card has balance of 0" do
    expect(oystercard.balance).to be 0
  end

  it "test that the card has been topped up?" do
    expect(oystercard).to respond_to :top_up
  end

  it "test if the maximum amount is reached" do
    expect { oystercard.top_up(Oystercard::MAX_AMOUNT) }.to raise_error("Maximum amount reached")
  end

  it "responds to the touch_in method" do
    expect(oystercard).to respond_to(:touch_in).with(1).argument
  end

  it "should raise an error if there is no balance on card" do
    oystercard = Oystercard.new
    expect{ oystercard.touch_in(barriers) }.to raise_error("No balance")
  end

  it "responds to the touch_out method" do
    expect(oystercard).to respond_to(:touch_out).with(1).argument
  end

  it "will check that the card has an empty list of journey's by default" do
    expect(oystercard.journey_history).to be_empty

  end

  context "A topped up card" do
    before { oystercard.top_up(amount) }

    it "test if fare has been deducted from card" do
      expect(oystercard.deducted(1)).to eq (amount - 1)
    end

    context "... and after touching in" do
      before { oystercard.touch_in(barriers) }

      it "in_journey? returns true after touching in" do
        expect(oystercard).to be_in_journey
      end

      it "will deduct my balance by the minimum fare after touching out" do
        expect { oystercard.touch_out(barriers) }.to change { oystercard.balance } .by(-1)
      end

      it "will remember the station when card touched in" do
        expect{ oystercard.touch_in(barriers)}
      end

      it "will forget the station when touched out" do
        oystercard.touch_out(barriers)
        expect(oystercard.entry_barrier).to be nil
      end

      it "will check that it stores a journey" do
        oystercard.touch_out(barriers)
        expect(oystercard.journey_history).not_to be_empty
      end
    end
  end
end
