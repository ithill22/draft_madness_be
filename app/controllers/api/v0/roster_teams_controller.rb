class Api::V0::RosterTeamsController < ApplicationController
  def create
    roster_team = RosterTeam.create!(roster_team_params)
    render json: RosterTeamSerializer.new(roster_team), status: 201
  end

  private

  def roster_team_params
    params.require(:roster_team).permit(:user_league_id, :api_team_id)
  end
end