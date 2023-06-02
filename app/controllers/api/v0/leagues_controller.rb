class Api::V0::LeaguesController < ApplicationController
  def index
    user = User.find_by(user_id: params[:user_id])
    leagues = user.leagues
    render json: LeagueSerializer.new(leagues), status: 200
  end

  def create
    league = League.create(league_params)
    render json: LeagueSerializer.new(league), status: 201
  end

  private

  def league_params
    params.require(:league).permit(:name, :draft_time, :draft_date, :manager_id)
  end
end