class Api::V0::Leagues::UserLeaguesController < ApplicationController
  def index
    league = League.find(params[:league_id])
    user_leagues = league.user_leagues
    render json: UserLeagueSerializer.new(user_leagues), status: 200
  end
end