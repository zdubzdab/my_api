class Api::V1::Admin::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_with_token!, only: [:update, :destroy]
  load_and_authorize_resource
  respond_to :json

  def update
    user = User.find_by_id(params[:id])

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    email = user.email
    if user.destroy
      render json: "You've successfully deleted user with email #{email}"
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :user_role, :auth_token)
    end

end
