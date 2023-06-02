class Api::V0::UsersController < ApplicationController
  def creategit 
    user = User.find_or_create_by(email: user_params[:email])
    user.update(user_params)
    render json: UserSerializer.new(user), status: 200
  end

  private

  def user_params
    params.permit(:name, :email, :google_id, :auth_token)
  end
end