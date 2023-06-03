class TeamFacade
  def all_teams
    format_team_data.map do |team_data|
      Team.new(team_data)
    end
  end

  private

  def service
    @_service ||= SportRadarService.new
  end

  def all_team_data
    @_all_team_data ||= service.all_teams
  end

  def format_team_data
    all_team_data.map do |team_data|

    end
  end 
end