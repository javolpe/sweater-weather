class Api::V1::SessionsController < ApplicationController
  def create 
    return bad_login if !params[:downcase] && !params[:email]
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      @serial = UsersSerializer.new(user)
      render json: @serial
    else 
      return bad_login
    end
  end

end