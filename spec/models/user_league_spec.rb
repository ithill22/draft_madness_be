require 'rails_helper'

RSpec.describe UserLeague, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:league) }
    it { should have_many(:roster_teams) }
  end
end