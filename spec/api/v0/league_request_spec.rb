require 'rails_helper'

RSpec.describe 'League Requests' do
  before(:each) do
    @user = User.create(name: 'Bernie Sanders',
      email: 'feel.the.bernnnn@gmail.com',
      google_id: '0123456789',
      auth_token: 'a;skt821498435nsdioopa7123h0dfk')
    @new_params = {
      name: 'Test League',
      draft_time: '12:00',
      draft_date: '2020-08-01',
      manager_id: 1
    }
  describe 'Create a new league' do
    it 'can create a league' do
      post '/api/v0/leagues', params: @new_params.to_json, headers: { 'Content-Type' => 'application/json'}

      expect(response).to be_successful
      expect(response).to have_http_status(200)

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
end