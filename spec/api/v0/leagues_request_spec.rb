require 'rails_helper'

RSpec.describe 'Leagues Requests' do
  describe 'Create a new league' do
    describe 'Happy Path' do
      it 'can create a league' do
        @new_params = {
          name: 'Test League',
          draft_time: '2000-01-01T12:00:00.000Z',
          draft_date: '2020-08-01',
          manager_id: 1
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v0/leagues', headers: headers, params: JSON.generate(league: @new_params)

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_a(Hash)
        expect(data[:data]).to be_a(Hash)

        expect(data[:data]).to have_key(:type)
        expect(data[:data][:type]).to eq('league')

        expect(data[:data]).to have_key(:id)
        expect(data[:data][:id]).to be_an(String)
        
        expect(data[:data]).to have_key(:attributes)
        expect(data[:data][:attributes]).to be_a(Hash)

        expect(data[:data][:attributes]).to have_key(:name)
        expect(data[:data][:attributes][:name]).to eq(@new_params[:name])

        expect(data[:data][:attributes]).to have_key(:draft_time)
        expect(data[:data][:attributes][:draft_time]).to eq(@new_params[:draft_time])
        
        expect(data[:data][:attributes]).to have_key(:draft_date)
        expect(data[:data][:attributes][:draft_date]).to eq(@new_params[:draft_date])

        expect(data[:data][:attributes]).to have_key(:manager_id)
        expect(data[:data][:attributes][:manager_id]).to eq(@new_params[:manager_id])
      end
    end

    describe 'Sad Path' do
      it 'returns an error if attributes are missing' do
        @bad_params = {
          name: 'Test League',
          draft_time: '',
          draft_date: '2020-08-01',
          manager_id: 1
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v0/leagues', headers: headers, params: JSON.generate(league: @bad_params)

        expect(response).to_not be_successful
        expect(response).to have_http_status(422)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data).to be_a(Hash)
        expect(data[:errors][:detail]).to eq("Validation failed: Draft time can't be blank")
      end
    end
  end

  describe 'Send all leagues' do
    before(:each) do
      @user_1 = User.create!(name: "John Doe", email: "john.doe@turing.edu", auth_token: "abc123", google_id: "1234567890")
      @user_2 = User.create!(name: "Jane Doe", email: "jane.doe@turing.edu", auth_token: "def456", google_id: "0987654321")

      @league_1 = League.create!(name: "League 1", draft_time: "8:00 PM", draft_date: "2021-08-01", manager_id: @user_1.id)
      @league_2 = League.create!(name: "League 2", draft_time: "8:00 PM", draft_date: "2021-08-01", manager_id: @user_2.id)
      @league_3 = League.create!(name: "League 3", draft_time: "8:00 PM", draft_date: "2021-08-01", manager_id: @user_2.id)

      @user_league_1 = UserLeague.create!(user_id: @user_1.id, league_id: @league_1.id)
      @user_league_2 = UserLeague.create!(user_id: @user_1.id, league_id: @league_2.id)
      @user_league_3 = UserLeague.create!(user_id: @user_2.id, league_id: @league_3.id)
    end
    it 'can send all leagues for a user' do
      get "/api/v0/users/#{@user_1.auth_token}/leagues"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:data]).to be_an(Array)
      expect(json[:data].count).to eq(2)
      
      json[:data].each do |league|
        expect(league).to have_key(:type)
        expect(league[:type]).to eq('league')

        expect(league).to have_key(:id)
        expect(league[:id]).to be_an(String)

        expect(league).to have_key(:attributes)
        expect(league[:attributes]).to be_a(Hash)

        expect(league[:attributes]).to have_key(:name)
        expect(league[:attributes][:name]).to be_a(String)
        
        expect(league[:attributes]).to have_key(:draft_time)
        expect(league[:attributes][:draft_time]).to be_a(String)
        
        expect(league[:attributes]).to have_key(:draft_date)
        expect(league[:attributes][:draft_date]).to be_a(String)

        expect(league[:attributes]).to have_key(:manager_id)
        expect(league[:attributes][:manager_id]).to be_an(Integer)
      end
    end
  end

  describe 'Send a single league' do
    it 'can send a single league' do
      @user_1 = User.create!(name: "John Doe", email: "john.doe@turing.edu", auth_token: "abc123", google_id: "1234567890")
      @league_1 = League.create!(name: "League 1", draft_time: "8:00 PM", draft_date: "2021-08-01", manager_id: @user_1.id)
      get "/api/v0/leagues/#{@league_1[:id]}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:data]).to be_a(Hash)

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('league')

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_an(String)

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)

      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes][:name]).to be_a(String)
      
      expect(json[:data][:attributes]).to have_key(:draft_time)
      expect(json[:data][:attributes][:draft_time]).to be_a(String)
      
      expect(json[:data][:attributes]).to have_key(:draft_date)
      expect(json[:data][:attributes][:draft_date]).to be_a(String)

      expect(json[:data][:attributes]).to have_key(:manager_id)
      expect(json[:data][:attributes][:manager_id]).to be_an(Integer)
    end
  end

  describe 'Update a league' do
    it 'can update a league' do
      @user_1 = User.create!(name: "John Doe", email: "john.doe@turing.edu", auth_token: "abc123", google_id: "1234567890")
      @league_1 = League.create!(name: "League 1", draft_time: "8:00 PM", draft_date: "2021-08-01", manager_id: @user_1.id)
      @updated_params = { name: "Super League", draft_time: "9:00 PM", draft_date: "2021-08-02", manager_id: @user_1.id }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v0/leagues/#{@league_1.id}", headers: headers, params: JSON.generate(league: @updated_params)


      expect(response).to be_successful
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:data]).to be_a(Hash)

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('league')

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_an(String)

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)

      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes][:name]).to eq(@updated_params[:name])
    end
  end

  describe 'Delete a league' do
    it 'can delete a league' do
      @user_1 = User.create!(name: "John Doe", email: "john.doe@turing.edu", auth_token: "abc123", google_id: "1234567890")
      @league_1 = League.create!(name: "League 1", draft_time: "8:00 PM", draft_date: "2021-08-01", manager_id: @user_1.id)
      @league_2 = League.create!(name: "League 2", draft_time: "9:00 PM", draft_date: "2021-08-02", manager_id: @user_1.id)

      expect(League.count).to eq(2)

      delete "/api/v0/leagues/#{@league_1[:id]}"

      expect(response).to be_successful
      expect(response).to have_http_status(204)
      expect(League.count).to eq(1)
    end
  end
end