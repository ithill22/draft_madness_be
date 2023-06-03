class TeamFacade
  def one_team(id)
    Team.new(team_data(id))
  end

  def all_teams
    format_team_data.map do |team_data|
      Team.new(team_data)
    end
  end

  private

  def service
    @_service ||= SportRadarService.new
  end

  def team_data(id)
    @_team_data ||= service.one_team(id)
  end

  def all_team_data
    @_all_team_data ||= service.all_teams
  end

  def format_team_data
    teams = all_team_data[:brackets].map do |bracket|
      region = bracket[:name]
      bracket[:participants].map do |participant|
        {
          id: participant[:id],
          type: participant[:type],
          name: participant[:name],
          seed: participant[:seed],
          region: region
        }
      end
    end
    teams.flatten
  end
end