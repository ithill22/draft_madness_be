require 'rails_helper'

RSpec.describe 'UserLeague Requests' do
  before(:each) do
    @user = User.create(name: 'Bernie Sanders', email: 'feel.the.bernnnn@gmail.com', google_id: '0123456789', auth_token: 'a;skt821498435nsdioopa7123h0dfk')
    @league = League.create(name: 'Frivolous Fanatics', draft_time: '12:00:00', draft_date: '2021-09-09', manager_id: @user.id)
    @params = {
      user_id: @user.id,
      league_id: @league.id
    }
  end

  describe 'happy_path' do
    it 'can create a new user_league from params' do
      post '/api/v0/user_leagues', params: @params.to_json, headers: { 'Content-Type' => 'application/json'}

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
end