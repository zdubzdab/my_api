class Api::V1::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_with_token!, only: [:update, :destroy]
  load_and_authorize_resource
  respond_to :json

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def index
    respond_with User.all
  end

  def show
    respond_with User.find(params[:id])
  end

  def destroy
    email = current_user.email
    if current_user.destroy
      render json: "You've successfully deleted your account with email #{email}"
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :user_role, :auth_token)
    end
end
