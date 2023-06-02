require 'rails_helper'

RSpec.describe 'User Requests' do
  describe 'can create a new user from params' do
    before(:each) do
      @valid_params = {
        name: 'Bernie Sanders',
        email: 'feel.the.bernnnn@gmail.com',
        google_id: '0123456789',
        auth_token: 'a;skt821498435nsdioopa7123h0dfk'
      }
    end
    it 'can create a user' do
      post 'api/v0/users', params: @valid_params.to_json, headers: { 'Content-Type' => 'application/json'}

      expect(response).to be_successful
      expect(response).to have_http_status(:created)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('user')

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_an(Integer)

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to be_a(Hash)

      expect(data[:data][:attributes]).to have_key(:name)
      expect(data[:data][:attributes][:name]).to eq(@valid_params[:name])

      expect(data[:data][:attributes]).to have_key(:email)
      expect(data[:data][:attributes][:email]).to eq(@valid_params[:email])

      expect(data[:data][:attributes]).to have_key(:google_id)
      expect(data[:data][:attributes][:google_id]).to eq(@valid_params[:google_id])

      expect(data[:data][:attributes]).to have_key(:auth_token)
      expect(data[:data][:attributes][:auth_token]).to eq(@valid_params[:auth_token])
    end
  end
end