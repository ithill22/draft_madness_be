require 'rails_helper'

RSpec.describe SportRadarService do
  context 'instance methods' do
    context '#all_teams' do
      it 'returns all teams', :vcr do
        sleep(1)
        search = SportRadarService.new.all_teams

        expect(search).to be_a(Hash)
        expect(search[:brackets]).to be_an(Array)
        bracket = search[:brackets].first

        expect(bracket).to have_key(:name)
        expect(bracket[:name]).to be_a(String)

        expect(bracket).to have_key(:participants)
        expect(bracket[:participants]).to be_an(Array)
        team = bracket[:participants].first

        expect(team).to have_key(:id)
        expect(team[:id]).to be_a(String)

        expect(team).to have_key(:name)
        expect(team[:name]).to be_a(String)

        expect(team).to have_key(:seed)
        expect(team[:seed]).to be_a(Integer)
      end
    end
  end
end