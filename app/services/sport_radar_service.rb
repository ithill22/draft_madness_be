class SportRadarService
  def all_teams
    get_url('/ncaamb/trial/v8/en/tournaments/86f1f414-88e9-4ad1-be69-740f4db52183/summary.json')
  end

  def conn
    sleep(1)
    Faraday.new(url: 'https://api.sportradar.us') do |f|
      f.params['api_key'] = ENV['SPORT_RADAR_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end