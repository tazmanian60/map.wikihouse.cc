class MapsController < ApplicationController

  before_action :authenticate

  def show
    @user = session[:user]
  end

end
