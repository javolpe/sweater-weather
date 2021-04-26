class Api::V1::UsersController < ApplicationController 
  def create 
    new_user = User.create!(user_params)
    @serial = UsersSerializer.new(new_user)
    render json: @serial
  end

  private

  def user_params
    params[:email] = params[:email].downcase
    params.permit(:email, :password, :password_confirmation)
  end
end