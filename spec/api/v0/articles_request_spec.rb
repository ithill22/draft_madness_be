require 'rails_helper'

RSpec.describe 'Articles Request' do
  describe 'all articles' do
    it 'can retrieve and return all articles', :vcr do
      get '/api/v0/articles'

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      articles = JSON.parse(response.body, symbolize_names: true)
      expect(articles).to be_a(Hash)
      expect(articles[:data]).to be_an(Array)
      
      article = articles[:data].first
      expect(article).to have_key(:attributes)
      expect(article).to have_key(:id)

      attributes = article[:attributes]
      expect(attributes).to have_key(:headline)
      expect(attributes[:headline]).to be_a(String)
      expect(attributes).to have_key(:url)
      expect(attributes[:url]).to be_a(String)
      expect(attributes).to have_key(:date)
      expect(attributes[:date]).to be_a(String)
    end
  end
end