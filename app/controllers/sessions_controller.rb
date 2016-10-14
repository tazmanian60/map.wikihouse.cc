class SessionsController < ApplicationController
  def create
    p request.env["omniauth.auth"].inspect
    render plain: request.env["omniauth.auth"]
  end
end
