# frozen_string_literal: true

# Handles user authentication by managing login (create),
# logout (destroy), and rendering the login form (new).
class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new; end

  def create
    # Change this to find user by username instead of email
    user = User.find_by(username: params[:username])

    # Check for valid username and password, or hardcoded admin check
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Username or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
