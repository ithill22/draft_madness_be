require 'rails_helper'

RSpec.describe ArticleFacade do
  describe 'instance methods' do
    before(:each) do
      @facade = ArticleFacade.new
    end
    
    describe '#all_articles' do
      it 'returns ten articles', :vcr do
        expect(@facade.all_articles).to be_an(Array)
        expect(@facade.all_articles.first).to be_a(Article)
        expect(@facade.all_articles.count).to eq(10)
      end
    end
  end
end