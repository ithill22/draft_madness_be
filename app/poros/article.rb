class Article
  attr_reader :id, :headline, :url, :date

  def initialize(id, data)
    @id = id
    @headline = data[:abstract]
    @url = data[:web_url]
    @date = format_date(data[:pub_date])
  end

  def format_date(date)
    DateTime.parse(date).strftime('%B %-d, %Y')
  end
end