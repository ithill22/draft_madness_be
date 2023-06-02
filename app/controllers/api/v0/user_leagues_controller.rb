class Api::V0::UserLeaguesController < ApplicationController
  def create
    user_league = UserLeague.create!(user_league_params)
    render json: UserLeagueSerializer.new(user_league), status: 201
  end

  private

  def user_league_params
    params.require(:user_league).permit(:user_id, :league_id)
  end
end