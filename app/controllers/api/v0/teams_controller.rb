class Api::v0::TeamsController < ApplicationController
  def index
    teams = TeamFacade.new.all_teams
    render json: TeamSerializer.new(teams)
  end
end