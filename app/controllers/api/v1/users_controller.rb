class Api::V1::UsersController < ApplicationController 
  def create 
    new_user = User.new(user_params)
    if new_user.save
      
    end
  end

  private

  def user_params
    params[:email] = params[:email].downcase
    params.permit(:email, :password, :password_confirmation)
  end
end