class Api::V1::SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)
    if user == nil
      render json: { errors: "There is not user in db with email #{user_email}" }, status: 422
    elsif user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find_by(auth_token: request.headers['Authorization'])
    user.generate_authentication_token!
    user.save
    render json: "You've successfully sign out. Your new authication token are: #{user.auth_token}"
  end
end
