class Api::V0::Users::LeaguesController < ApplicationController
  def index
    user = User.find_by!(auth_token: params[:user_id])
    leagues = user.leagues
    render json: LeagueSerializer.new(leagues), status: 200
  end
end