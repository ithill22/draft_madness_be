class Api::V0::ArticlesController < ApplicationController
  def index
    articles = ArticleFacade.new.all_articles
    render json: ArticleSerializer.new(articles)
  end
end