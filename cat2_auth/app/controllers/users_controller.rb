class UsersController < ApplicationController
  before_action :require_logged_out

  def create
    @user = User.new(user_params)
    if @user.save!
      login_user!(@user)
      redirect_to cats_url
    else
      render json: @user.errors.full_messages, status: 400
    end
  end

  def new
    render :new
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
