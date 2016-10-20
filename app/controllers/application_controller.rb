class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login, :current_user
  RSpotify::authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_KEY'])
  private

  def require_login
    redirect_to new_user_path unless session.include? :user_id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
