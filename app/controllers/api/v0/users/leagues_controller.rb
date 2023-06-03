class Api::V0::Users::LeaguesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    leagues = user.leagues
    render json: LeagueSerializer.new(leagues), status: 200
  end

  def show
    league = League.find(params[:id])
    render json: LeagueSerializer.new(league), status: 200
  end

  def update
    league = League.find(params[:id])
    league.update(league_params)
    render json: LeagueSerializer.new(league), status: 200
  end

  def destroy
    league = League.find(params[:id])
    league.destroy
  end

  private
  
  def league_params
    params.require(:league).permit(:name, :draft_time, :draft_date, :manager_id)
  end
end