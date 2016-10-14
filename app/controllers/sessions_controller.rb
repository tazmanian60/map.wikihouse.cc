class SessionsController < ApplicationController

  def create
    session[:user] = request.env["omniauth.auth"]["info"]["nickname"]
    redirect_to root_path
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end

end
