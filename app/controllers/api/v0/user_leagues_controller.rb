class Api::V0::UserLeaguesController < ApplicationController
  def create
    user_league = UserLeague.create!(user_league_params)
    render json: UserLeagueSerializer.new(user_league), status: 201
  end

  def destroy
    user_league = UserLeague.find(user_league_params[:user_league_id])
    user_league.destroy
  end

  private

  def user_league_params
    params.require(:user_league).permit(:user_league_id, :user_id, :league_id)
  end
end