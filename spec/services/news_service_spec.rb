require 'rails_helper'

RSpec.describe NewsService do
  context 'instance methods' do
    context '#all_articles' do
      it 'returns all articles related to ncaa basketball tournament', :vcr do
        articles = NewsService.new.all_articles

        expect(articles).to be_a(Hash)
        expect(articles.dig(:response, :docs)).to be_an(Array)
        article = articles.dig(:response, :docs).first

        expect(article).to have_key(:abstract)
        expect(article[:abstract]).to be_a(String)

        expect(article).to have_key(:web_url)
        expect(article[:web_url]).to be_a(String)

        expect(article).to have_key(:pub_date)
        expect(article[:pub_date]).to be_a(String)
      end
    end
  end
end