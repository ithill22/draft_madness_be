require 'rails_helper'

RSpec.describe RosterTeam, type: :model do
  describe 'relationships' do
    it { should belong_to(:user_league) }
    it { should have_one(:user).through(:user_league) }
    it { should have_one(:league).through(:user_league) }
  end

  describe 'validations' do
    it { should validate_presence_of(:api_team_id) }
    it { should validate_presence_of(:user_league_id) }
  end
end