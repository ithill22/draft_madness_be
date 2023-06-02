require 'rails_helper'

RSpec.describe 'UserLeague Requests' do
  describe 'UserLeague creation' do
    before(:each) do
      @user = User.create(name: 'Bernie Sanders', email: 'feel.the.bernnnn@gmail.com', google_id: '0123456789', auth_token: 'a;skt821498435nsdioopa7123h0dfk')
      @league = League.create(name: 'Frivolous Fanatics', draft_time: '12:00:00', draft_date: '2021-09-09', manager_id: @user.id)
      @params = {
        user_id: @user.id,
        league_id: @league.id
      }
      @bad_params = {
        league_id: @league.id,
        user_id: ''
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
      @user_league = UserLeague.create(user_id: @user.id, league_id: @league.id)
      @valid_params = { user_league_id: @user_league.id }
      @invalid_params = { user_league_id: '1a24573bb5' }
      @headers = { 'Content-Type' => 'application/json' }
    end

    describe 'happy_path' do
      it 'can delete a user_league' do
        delete '/api/v0/user_leagues', headers: @headers, params: JSON.generate(user_league: @valid_params)

        expect(response).to be_successful
        expect(response).to have_http_status(204)
      end
    end

    describe 'sad_path' do
      it 'returns an error if user_league_id is invalid' do
        delete '/api/v0/user_leagues', headers: @headers, params: JSON.generate(user_league: @invalid_params)

        expect(response).to_not be_successful
        expect(response).to have_http_status(404)
      end
    end
  end
end