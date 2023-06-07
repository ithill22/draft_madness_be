require 'rails_helper'

RSpec.describe 'Team Requests' do
  describe 'all teams' do
    it 'can retrieve and return all teams', :vcr do
      sleep(1)
      get '/api/v0/teams'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_an(Array)
      team = data[:data].first

      expect(team).to have_key(:id)
      expect(team[:id]).to be_a(String)

      expect(team).to have_key(:type)
      expect(team[:type]).to eq('team')

      expect(team).to have_key(:attributes)
      expect(team[:attributes]).to be_a(Hash)

      expect(team[:attributes]).to have_key(:name)
      expect(team[:attributes][:name]).to be_a(String)

      expect(team[:attributes]).to have_key(:region)
      expect(team[:attributes][:region]).to be_a(String)

      expect(team[:attributes]).to have_key(:seed)
      expect(team[:attributes][:seed]).to be_a(Integer)
    end
  end

  describe 'one team' do
    it 'happy path', :vcr do
      team_id = 'c10544de-e3bd-4776-ba2e-83df8c017fd1'
      sleep(1)
      get "/api/v0/teams/#{team_id}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_a(String)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('team')

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to be_a(Hash)

      expect(data[:data][:attributes]).to have_key(:name)
      expect(data[:data][:attributes][:name]).to be_a(String)

      expect(data[:data][:attributes]).to have_key(:region)
      expect(data[:data][:attributes][:region]).to be_a(String)

      expect(data[:data][:attributes]).to have_key(:seed)
      expect(data[:data][:attributes][:seed]).to be_a(Integer)
    end
  end
end