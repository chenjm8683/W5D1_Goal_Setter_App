class UsersController < ApplicationController
  before_action :ensure_logged_out, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to goals_url
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @comments = @user.comments
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
