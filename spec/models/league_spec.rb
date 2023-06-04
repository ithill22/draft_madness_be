require 'rails_helper'

RSpec.describe League, type: :model do
  describe 'relationships' do
    it { should have_many(:user_leagues) }
    it { should have_many(:users).through(:user_leagues) }
    it { should have_many(:roster_teams).through(:user_leagues) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:draft_time) }
    it { should validate_presence_of(:draft_date) }
    it { should validate_presence_of(:manager_id) }
  end
end