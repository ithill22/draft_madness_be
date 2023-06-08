class Article
  attr_reader :headline, :url, :date

  def initialize(data)
    @headline = data[:abstract]
    @url = data[:web_url]
    @date = format_date(data[:pub_date])
  end

  def format_date(date)
    DateTime.parse(date).strftime('%B %-d, %Y')
  end
end