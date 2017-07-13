require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }
  let(:station) { double('station') }
  let(:amount) { 5 }

  it "tests that an initialized card has balance of 0" do
    expect(oystercard.balance).to be 0
  end

  it "test that the card has been topped up?" do
    expect{ oystercard.top_up(amount) }.to change { oystercard.balance }.by amount
  end

  it "test if the maximum amount is reached" do
    expect { oystercard.top_up(Oystercard::MAX_AMOUNT) }.to raise_error("Maximum amount reached")
  end

  it "should raise an error if there is no balance on card when touched in" do
    expect{ oystercard.touch_in(station) }.to raise_error("No balance")
  end

  it "will check that the card has an empty list of journeys by default" do
    expect(oystercard.journey_history).to be_empty
  end

  context "A topped up card" do
    before { oystercard.top_up(amount) }

    context "not touched in and touched out" do
      it 'will charge the penalty fare' do
        expect{ oystercard.touch_out(station) }.to change { oystercard.balance } .by -Journey::PENALTY_FARE
      end

      it 'will store a journey' do
        oystercard.touch_out(station)
        expect(oystercard.journey_history).not_to be_empty
      end
    end

    context "... and after touching in" do
      before { oystercard.touch_in(station) }

      context "touching in AGAIN before touching out" do
        it 'will charge the penalty fare' do
          expect{ oystercard.touch_in(station) }.to change { oystercard.balance } .by -Journey::PENALTY_FARE
        end
      end

      it "in_journey? returns true" do
        oystercard.touch_in(station)
        expect(oystercard).to be_in_journey
      end

      it "will deduct my balance by the minimum fare after touching out" do
        expect { oystercard.touch_out(station) }.to change { oystercard.balance } .by(-Journey::MINIMUM_FARE)
      end

      it "will store a journey" do
        expect(oystercard.journey_history).not_to be_empty
      end
    end
  end
end
