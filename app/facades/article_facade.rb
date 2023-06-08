class ArticleFacade
  def all_articles
    articles = service.all_articles.dig(:response, :docs)
    articles.map do |article|
      Article.new(articles.index(article), article)
    end
  end

  private

  def service
    @_service ||= NewsService.new
  end
end