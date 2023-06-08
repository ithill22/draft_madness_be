class NewsService
  def all_articles
    get_url('/svc/search/v2/articlesearch.json?q=ncaa basketball tournament&api-key=w5kLh4F33JzXtYmPepoAJMKFBcOUIEfm')
  end

  def conn
    Faraday.new(url: 'https://api.nytimes.com') do |f|
      f.params['api-key'] = ENV['NYT_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end