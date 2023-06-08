class Team
  attr_reader :id, :type, :name, :region, :seed, :games_won

  def initialize(data)
    @id = data[:id]
    @type = data[:type]
    @name = data[:name]
    @region = data[:region]
    @seed = data[:seed]
    @games_won = data[:games_won]
  end
end