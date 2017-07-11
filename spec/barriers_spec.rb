# require 'barriers'
# require 'oystercard'
#
# describe "Barriers" do
#   subject(:barriers) { Barriers.new }
#   let(:card) {Oystercard.new}
#
#   it "test if the card is touched in?" do
#     expect(barriers.touch_in(card)).to include card
#   end
#
#   it "test if the card is touched out?" do
#     barriers.touch_in(card)
#     expect(barriers.touch_out(card)).to eq card
#   end
#
#   it "test if the card is still in journey" do
#     barriers.touch_in(card)
#     barriers.touch_out(card)
#     expect(barriers.in_journey?(card)).to be true
#   end
# end
