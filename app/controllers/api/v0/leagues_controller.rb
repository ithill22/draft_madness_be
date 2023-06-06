class Api::V0::LeaguesController < ApplicationController
  def show
    league = League.find(params[:id])
    render json: LeagueSerializer.new(league), status: 200
  end

  def create
    league = League.create!(league_params)
    UserLeague.create!(user_id: league.manager_id, league_id: league.id, user_name: User.find(league.manager_id).name)
    render json: LeagueSerializer.new(league), status: 201
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