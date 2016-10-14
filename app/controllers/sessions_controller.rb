class SessionsController < ApplicationController

  def create
    session[:user] = request.env["omniauth.auth"]["info"]["nickname"]
    redirect_to root_path
  end

  def destroy
    session.delete(:user)
    # render plain: session[:user]
    redirect_to root_path
  end

end
