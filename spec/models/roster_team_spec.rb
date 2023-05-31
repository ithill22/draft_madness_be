require 'rails_helper'

RSpec.describe RosterTeam, type: :model do
  describe 'relationships' do
    it { should belong_to(:user_league) }
    it { should have_one(:user).through(:user_league) }
    it { should have_one(:league).through(:user_league) }
  end
end