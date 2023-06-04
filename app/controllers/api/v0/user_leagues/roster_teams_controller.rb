class Api::V0::UserLeagues::RosterTeamsController < ApplicationController
  def index
    roster_teams = RosterTeam.where(user_league_id: params[:user_league_id])
    render json: RosterTeamSerializer.new(roster_teams), status: 200
  end

  private

  def roster_team_params
    params.require(:roster_team).permit(:user_league_id, :api_team_id)
  end
end