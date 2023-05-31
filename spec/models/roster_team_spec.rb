require 'rails_helper'

RSpec.describe RosterTeam, type: :model do
  describe 'relationships' do
    it { should belong_to(:user_league) }
    it { should belong_to(:user).through(:user_league) }
    it { should belong_to(:league).through(:user_league) }
  end
end