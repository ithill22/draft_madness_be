class Api::V0::Leagues::UsersController < ApplicationController
  def index
    league = League.find(params[:league_id])
    users = league.users
    render json: UserSerializer.new(users), status: 200
  end
end