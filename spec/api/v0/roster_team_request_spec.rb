require 'rails_helper'

RSpec.describe 'RosterTeam Requests' do
  before(:each) do
    @user = @user = User.create!(name: 'Bernie Sanders', email: 'feel.the.bernnnn@gmail.com', google_id: '0123456789', auth_token: 'askt.821498435nsdioopa7123h0dfk')
    @league = League.create!(name: 'March Madness', draft_time: '8:00 PM', draft_date: '2021-03-18', manager_id: @user.id)
    @user_league = UserLeague.create!(user_id: @user.id, league_id: @league.id)
  end

  describe 'can create a new roster_team from params' do
    it 'happy path' do
      post '/api/v0/roster_teams', headers: { 'Content-Type' => 'application/json' }, params: JSON.generate(roster_team: { user_league_id: @user_league.id, team_id: 'c10544de-e3bd-4776-ba2e-83df8c017fd1' })

      expect(response).to be_successful
      expect(response).to have_http_status(201)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('roster_team')

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_an(String)

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to be_a(Hash)

      expect(data[:data][:attributes]).to have_key(:user_league_id)
      expect(data[:data][:attributes][:user_league_id]).to eq(@user_league.id)

      expect(data[:data][:attributes]).to have_key(:team_id)
      expect(data[:data][:attributes][:team_id]).to eq('c10544de-e3bd-4776-ba2e-83df8c017fd1')
    end

    it 'sad path: missing user_league_id' do
      post '/api/v0/roster_teams', headers: { 'Content-Type' => 'application/json' }, params: JSON.generate(roster_team: { team_id: 'c10544de-e3bd-4776-ba2e-83df8c017fd1' })

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:error][:details]).to eq('User league must exist')
    end

    it 'sad path: missing team_id' do
      post '/api/v0/roster_teams', headers: { 'Content-Type' => 'application/json' }, params: JSON.generate(roster_team: { user_league_id: @user_league.id })

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:error][:details]).to eq('Team must exist')
    end
  end
end