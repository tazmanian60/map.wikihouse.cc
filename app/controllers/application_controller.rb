class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def authenticate
      redirect_to '/auth/sign_in_with_slack' unless session[:user]
    end
end
