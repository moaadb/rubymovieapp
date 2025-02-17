# frozen_string_literal: true

# Defines current_user as a helper method to retrieve
# the logged-in user based on session[:user_id].
class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authorized
  helper_method :logged_in?, :admin?
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to root_path unless logged_in?
  end

  private

  def admin?
    current_user&.admin?
  end

  def admin_only
    redirect_to root_path unless admin?
  end

end
