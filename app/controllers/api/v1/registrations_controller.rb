class Api::V1::RegistrationsController  < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    user = User.new(user_params)
    # if params[:user_role]
    #   user.add_role params[:user_role]
    # end
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :user_role, :auth_token)
  end
end
