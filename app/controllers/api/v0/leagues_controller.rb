class Api::V0::LeaguesController < ApplicationController
  def create
    league = League.create(league_params)
    render json: LeagueSerializer.new(league), status: 201
  end

  private

  def league_params
    params.require(:league).permit(:name, :draft_time, :draft_date, :manager_id)
  end
end