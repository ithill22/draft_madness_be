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
end