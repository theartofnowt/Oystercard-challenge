require 'journey'
describe Journey do

  subject(:journey) { described_class.new(starting_station) }
  let(:starting_station) { instance_double("station") }
  let(:end_station) { instance_double("station") }

  it 'shows a starting station when initialized' do
    expect(journey.starting_station).to eq starting_station
  end

  it 'registers an end station' do
    journey.finish(end_station)
    expect(journey.end_station).to eq end_station
  end

  it 'shows a journey in progess' do
    expect(journey.in_journey).to eq true
  end

  it 'shows a journey completed when touched out' do
    journey.finish(end_station)
    expect(journey.in_journey).to eq false
  end

  it 'calculates a fare for a finished journey' do
    journey.finish(end_station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

end
