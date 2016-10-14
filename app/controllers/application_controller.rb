class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def current_user
      @current_user ||= session[:user] if session[:user]
    end
    helper_method :current_user

    def authenticate
      redirect_to '/auth/sign_in_with_slack' unless session[:user]
    end
end
