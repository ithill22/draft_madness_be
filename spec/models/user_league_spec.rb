require 'rails_helper'

RSpec.describe UserLeague, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:league) }
    it { should have_many(:roster_teams) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:league_id) }
    it { should validate_presence_of(:user_name) }
  end
end