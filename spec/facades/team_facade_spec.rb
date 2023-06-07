require 'rails_helper'

RSpec.describe TeamFacade do
  describe 'instance methods', :vcr do
    before(:each) do
      @facade = TeamFacade.new
    end

    it 'returns all teams' do
      expect(@facade.all_teams).to be_an(Array)
      expect(@facade.all_teams.count).to eq(68)
      expect(@facade.all_teams.first).to be_a(Team)
    end
  end
end