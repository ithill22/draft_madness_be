class Api::V0::TeamsController < ApplicationController
  def index
    teams = TeamFacade.new.all_teams
    render json: TeamSerializer.new(teams)
  end

  def show
    team = TeamFacade.new.one_team(params[:id])
    render json: TeamSerializer.new(team)
  end
end