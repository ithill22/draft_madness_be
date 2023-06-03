require 'rails_helper'

RSpec.describe 'User Requests' do
  describe 'can create a new user from params' do
    before(:each) do
      @new_params = {
        name: 'Bernie Sanders',
        email: 'feel.the.bernnnn@gmail.com',
        google_id: '0123456789',
        auth_token: 'askt821498435nsdioopa7123h0dfk'
      }
      @headers = { 'Content-Type' => 'application/json'}
    end

    it 'can create a user' do
      post '/api/v0/users', headers: @headers, params: JSON.generate(user: @new_params)

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('user')

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_an(String)

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to be_a(Hash)

      expect(data[:data][:attributes]).to have_key(:name)
      expect(data[:data][:attributes][:name]).to eq(@new_params[:name])

      expect(data[:data][:attributes]).to have_key(:email)
      expect(data[:data][:attributes][:email]).to eq(@new_params[:email])

      expect(data[:data][:attributes]).to have_key(:google_id)
      expect(data[:data][:attributes][:google_id]).to eq(@new_params[:google_id])

      expect(data[:data][:attributes]).to have_key(:auth_token)
      expect(data[:data][:attributes][:auth_token]).to eq(@new_params[:auth_token])
    end

    it 'can find a user if they already exist' do
      User.create(@new_params)
      params = {
        name: 'Bernie Sanders',
        email: 'feel.the.bernnnn@gmail.com',
        google_id: '0123456789',
        auth_token: 'uifdtjnalkdsotiua2307623523htkg0we89ru5q3n'
      }

      post '/api/v0/users', headers: @headers, params: JSON.generate(user: params)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(User.all.count).to eq(1)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('user')

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_an(String)

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to be_a(Hash)

      expect(data[:data][:attributes]).to have_key(:name)
      expect(data[:data][:attributes][:name]).to eq(params[:name])

      expect(data[:data][:attributes]).to have_key(:email)
      expect(data[:data][:attributes][:email]).to eq(params[:email])

      expect(data[:data][:attributes]).to have_key(:google_id)
      expect(data[:data][:attributes][:google_id]).to eq(params[:google_id])

      expect(data[:data][:attributes]).to have_key(:auth_token)
      expect(data[:data][:attributes][:auth_token]).to eq(params[:auth_token])
    end
  end

  describe 'can find a single user by id' do
    before(:each) do
      @user = User.create!(name: 'Bernie Sanders', email: 'feel.the.bernnnn@gmail.com', google_id: '0123456789', auth_token: 'askt821498435nsdioopa7123h0dfk')
      @headers = { 'Content-Type' => 'application/json' }
    end

    it 'happy path' do
      get "/api/v0/users/#{@user.auth_token}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)

      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('user')

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to be_an(String)

      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:attributes]).to be_a(Hash)

      expect(data[:data][:attributes]).to have_key(:name)
      expect(data[:data][:attributes][:name]).to eq(@user[:name])

      expect(data[:data][:attributes]).to have_key(:email)
      expect(data[:data][:attributes][:email]).to eq(@user[:email])

      expect(data[:data][:attributes]).to have_key(:google_id)
      expect(data[:data][:attributes][:google_id]).to eq(@user[:google_id])

      expect(data[:data][:attributes]).to have_key(:auth_token)
      expect(data[:data][:attributes][:auth_token]).to eq(@user[:auth_token])
    end

    it 'sad path' do
      bad_auth_token = '12345677890llasdhfhlkjasdhgde'
      get "/api/v0/users/#{bad_auth_token}"

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:errors][:detail]).to eq("Couldn't find User with [WHERE \"users\".\"auth_token\" = $1]")
    end
  end
end