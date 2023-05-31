require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_leagues) }
    it { should have_many(:leagues).through(:user_leagues) }
    it { should have_many(:roster_teams).through(:user_leagues) }
  end

  describe 'validations' do
    
  end
end