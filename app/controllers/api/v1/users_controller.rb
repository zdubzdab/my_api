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
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: custom_json_for(user)
  end

  def destroy
    email = current_user.email
    if current_user.destroy
      render json: "You've successfully deleted your account with email #{email}"
    end
  end

  private
    def custom_json_for(user)
      list = { id: " #{user.id}",
                email: user.email.to_s,
                created_at: user.created_at.to_s
              }
      list.to_json
    end

    def user_params
      params.require(:user).permit(:email, :password, :user_role, :auth_token)
    end
end
