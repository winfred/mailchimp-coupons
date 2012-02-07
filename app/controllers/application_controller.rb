class ApplicationController < ActionController::Base
  protect_from_forgery
  def logged_in?
    not current_user.nil?
  end
  def current_user
    @current_user ||= session[:user] ? User.find(session[:user]) : nil
  end
end
