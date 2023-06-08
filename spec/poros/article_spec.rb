require 'rails_helper'

RSpec.describe Article do
  before(:each) do
    article_data
    @article = Article.new(@data)
  end
  describe 'initialize' do
    it 'exists and has attributes' do
      expect(@article).to be_a(Article)
      expect(@article.headline).to eq('Times sports writer Pete Thamel breaks down the NCAA tournament brackets and highlights the teams to watch. (Producer: Kassie Bracken)')
      expect(@article.url).to eq("https://www.nytimes.com/video/sports/1194817114941/ncaa-tournament-preview.html")
      expect(@article.date).to eq('March 13, 2006')
    end
  end
  describe 'format_date' do
    it 'formats a datetime to a readable date' do
      expect(@article.format_date('2023-04-06T09:00:56+0000')).to eq('April 6, 2023')
    end
  end
end