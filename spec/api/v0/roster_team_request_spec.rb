require 'rails_helper'

RSpec.describe 'RosterTeam Requests' do
  before(:each) do
    @user = @user = User.create!(name: 'Bernie Sanders', email: 'feel.the.bernnnn@gmail.com', google_id: '0123456789', auth_token: 'askt.821498435nsdioopa7123h0dfk')
    @user2 = User.create!(name: 'Betty White', email: 'always.golden@gmail.com', google_id: '1234567890', auth_token: 'askta.sdasdktsak_jt92sdfafk8476hdk_kasd')
    @league = League.create!(name: 'March Madness', draft_time: '8:00 PM', draft_date: '2021-03-18', manager_id: @user.id)
    @user_league = UserLeague.create!(user_id: @user.id, league_id: @league.id)
    @user_league2 = UserLeague.create!(user_id: @user2.id, league_id: @league.id)
    @roster_team1 = RosterTeam.create!(user_league_id: @user_league.id, api_team_id: 'aslkdhkalsdj-aklsjdhlkja-asdlkjhaklsj', score: 0)
    @roster_team2 = RosterTeam.create!(user_league_id: @user_league.id, api_team_id: 'mnxcbm-wioueyqoiuwmndsiuqywe-askjdhf', score: 1)
    @roster_team3 = RosterTeam.create!(user_league_id: @user_league2.id, api_team_id: 'aslkdhkalsdj-aklsjdhlkja-asdlkjhaklsj', score: 2)
  end

  describe 'can create a new roster_team from params' do
    it 'happy path' do
      post '/api/v0/roster_teams', headers: { 'Content-Type' => 'application/json' }, params: JSON.generate(roster_team: { user_league_id: @user_league.id, api_team_id: 'c10544de-e3bd-4776-ba2e-83df8c017fd1' })

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

      expect(data[:data][:attributes]).to have_key(:api_team_id)
      expect(data[:data][:attributes][:api_team_id]).to eq('c10544de-e3bd-4776-ba2e-83df8c017fd1')

      expect(data[:data][:attributes]).to have_key(:score)
    end

    it 'sad path: missing user_league_id' do
      post '/api/v0/roster_teams', headers: { 'Content-Type' => 'application/json' }, params: JSON.generate(roster_team: { api_team_id: 'c10544de-e3bd-4776-ba2e-83df8c017fd1' })

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:errors][:detail]).to eq("Validation failed: User league can't be blank, User league must exist")
    end

    it 'sad path: missing api_team_id' do
      post '/api/v0/roster_teams', headers: { 'Content-Type' => 'application/json' }, params: JSON.generate(roster_team: { user_league_id: @user_league.id })

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:errors][:detail]).to eq("Validation failed: Api team can't be blank")
    end
  end

  describe 'can retrieve all roster_teams for a user_league' do
    it 'happy path' do
      get "/api/v0/user_leagues/#{@user_league[:id]}/roster_teams"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_an(Array)
      expect(data[:data].count).to eq(2)
      roster_team = data[:data].first


      expect(roster_team).to have_key(:id)
      expect(roster_team[:id]).to be_a(String)

      expect(roster_team).to have_key(:type)
      expect(roster_team[:type]).to eq('roster_team')

      expect(roster_team).to have_key(:attributes)
      expect(roster_team[:attributes]).to be_a(Hash)

      expect(roster_team[:attributes]).to have_key(:user_league_id)
      expect(roster_team[:attributes][:user_league_id]).to be_a(Integer)

      expect(roster_team[:attributes]).to have_key(:api_team_id)
      expect(roster_team[:attributes][:api_team_id]).to be_a(String)

      expect(roster_team[:attributes]).to have_key(:score)
      expect(roster_team[:attributes][:score]).to be_a(Integer)
    end
  end
end