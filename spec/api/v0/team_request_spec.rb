require 'rails_helper'

RSpec.describe 'Team Requests' do
  describe 'all teams' do
    it 'can retrieve and return all teams' do
      get 'api/v0/teams'

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
end