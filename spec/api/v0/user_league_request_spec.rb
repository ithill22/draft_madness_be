require 'rails_helper'

RSpec.describe 'UserLeague Requests' do
  describe 'UserLeague creation' do
    before(:each) do
      @user = User.create(name: 'Bernie Sanders', email: 'feel.the.bernnnn@gmail.com', google_id: '0123456789', auth_token: 'a;skt821498435nsdioopa7123h0dfk')
      @league = League.create(name: 'Frivolous Fanatics', draft_time: '12:00:00', draft_date: '2021-09-09', manager_id: @user.id)
      @params = {
        user_id: @user.id,
        league_id: @league.id,
        user_name: @user.name
      }
      @bad_params = {
        league_id: @league.id,
        user_id: '',
        user_name: @user.name
      }
      @headers = { 'Content-Type' => 'application/json' }
    end

    describe 'happy_path' do
      it 'can create a new user_league from params' do
        post '/api/v0/user_leagues', headers: @headers, params: JSON.generate(user_league: @params)

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_a(Hash)
        expect(data[:data]).to be_a(Hash)

        expect(data[:data]).to have_key(:type)
        expect(data[:data][:type]).to eq('user_league')

        expect(data[:data]).to have_key(:id)
        expect(data[:data][:id]).to be_an(String)

        expect(data[:data]).to have_key(:attributes)
        expect(data[:data][:attributes]).to be_a(Hash)

        expect(data[:data][:attributes]).to have_key(:user_id)
        expect(data[:data][:attributes][:user_id]).to eq(@params[:user_id])

        expect(data[:data][:attributes]).to have_key(:league_id)
        expect(data[:data][:attributes][:league_id]).to eq(@params[:league_id])
      end
    end

    describe 'sad_path' do
      it 'returns an error if user_id is missing' do
        post '/api/v0/user_leagues', headers: @headers, params: JSON.generate(user_league: @bad_params)

        expect(response).to_not be_successful
        expect(response).to have_http_status(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_a(Hash)
        expect(data[:errors][:detail]).to eq("Validation failed: User can't be blank, User must exist")
      end
    end
  end

  describe 'UserLeague deletion' do
    before(:each) do
      @user = User.create(name: 'Bernie Sanders', email: 'feel.the.bernnnn@gmail.com', google_id: '0123456789', auth_token: 'a;skt821498435nsdioopa7123h0dfk')
      @league = League.create(name: 'Frivolous Fanatics', draft_time: '12:00:00', draft_date: '2021-09-09', manager_id: @user.id)
      @user_league = UserLeague.create(user_id: @user.id, league_id: @league.id, user_name: @user.name)
      @valid_params = { user_league_id: @user_league.id }
      @invalid_params = { user_league_id: '1a24573bb5' }
      @headers = { 'Content-Type' => 'application/json' }
    end

    describe 'happy_path' do
      it 'can delete a user_league' do
        delete "/api/v0/user_leagues/#{@user_league.id}"

        expect(response).to be_successful
        expect(response).to have_http_status(204)
      end
    end

    describe 'sad_path' do
      it 'returns an error if user_league_id is invalid' do
        delete '/api/v0/user_leagues/0'

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'Send All UserLeagues for a League' do
    before(:each) do
      @user1 = User.create!(name: 'Bob', email: 'bob@turing.edu', auth_token: 'abc123', google_id: '12345')
      @user2 = User.create!(name: 'Sally', email: 'sally@turing.edu,', auth_token: 'abc124', google_id: '12346')
      @league1 = League.create!(name: 'League 1', draft_time: '12:00', draft_date: '2021-08-01', manager_id: @user1.id)
      @user_league1 = UserLeague.create!(user_id: @user1.id, league_id: @league1.id, user_name: @user1.name)
      @user_league2 = UserLeague.create!(user_id: @user2.id, league_id: @league1.id, user_name: @user2.name)
    end
    describe 'happy path' do
      it 'can send all user_leagues for a league' do
        get "/api/v0/leagues/#{@league1.id}/user_leagues"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_an(Array)
        expect(json[:data].count).to eq(2)

        json[:data].each do |user_league|
          expect(user_league).to have_key(:id)
          expect(user_league[:id]).to be_an(String)

          expect(user_league).to have_key(:type)
          expect(user_league[:type]).to eq('user_league')

          expect(user_league).to have_key(:attributes)
          expect(user_league[:attributes]).to be_a(Hash)

          expect(user_league[:attributes]).to have_key(:user_id)
          expect(user_league[:attributes][:user_id]).to be_an(Integer)

          expect(user_league[:attributes]).to have_key(:league_id)
          expect(user_league[:attributes][:league_id]).to be_an(Integer)
        end
      end
    end

    describe 'sad path' do
      it 'returns an error if league_id is invalid' do
        get '/api/v0/leagues/0/user_leagues'

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Couldn't find League with 'id'=0")
      end
    end
  end

  describe 'Send One UserLeague' do
    before(:each) do
      @user1 = User.create!(name: 'Bob', email: 'bob@turing.edu', auth_token: 'abc123', google_id: '12345')
      @user2 = User.create!(name: 'Sally', email: 'sally@turing.edu,', auth_token: 'abc124', google_id: '12346')
      @league1 = League.create!(name: 'League 1', draft_time: '12:00', draft_date: '2021-08-01', manager_id: @user1.id)
      @user_league1 = UserLeague.create!(user_id: @user1.id, league_id: @league1.id, user_name: @user1.name)
      @user_league2 = UserLeague.create!(user_id: @user2.id, league_id: @league1.id, user_name: @user2.name)
    end
    describe 'happy path' do
      it 'can send one user_league' do
        get "/api/v0/user_leagues/#{@user_league1.id}"

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)

        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to be_an(String)

        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq('user_league')

        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)

        expect(json[:data][:attributes]).to have_key(:user_id)
        expect(json[:data][:attributes][:user_id]).to be_an(Integer)

        expect(json[:data][:attributes]).to have_key(:league_id)
        expect(json[:data][:attributes][:league_id]).to be_an(Integer)
      end
    end

    describe 'sad path' do
      it 'returns an error if user_league_id is invalid' do
        get '/api/v0/user_leagues/0'

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Couldn't find UserLeague with 'id'=0")
      end
    end
  end
end