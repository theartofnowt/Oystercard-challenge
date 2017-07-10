require 'oystercard'

describe Oystercard do
  subject(:oystercard){ described_class.new }

  it "tests that an initialized card has balance of 0" do
    expect(oystercard.balance).to be 0
  end

end
