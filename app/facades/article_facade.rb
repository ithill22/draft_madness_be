class ArticleFacade
  def all_articles
    articles = service.all_articles
    articles.dig(:response, :docs).map do |article|
      Article.new(article)
    end
  end

  private

  def service
    @_service ||= NewsService.new
  end
end