class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:destroy]
  before_action :require_logged_out, only: [:new, :create]
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user.nil?
      flash.now[:errors] = "Invalid username or password"
      redirect_to new_session_url
    else
      login_user!(user)
      redirect_to cats_url
    end
  end

  def destroy
    logout!
    redirect_to cats_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
