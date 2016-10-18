class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  private

    def current_user
      @current_user ||= session[:user] if session[:user]
    end
    helper_method :current_user

    def authenticate
      redirect_to '/auth/sign_in_with_slack' unless session[:user]
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
