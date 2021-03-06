class SessionsController < ApplicationController
  before_action :ensure_logged_in, only: [:destroy]
  before_action :ensure_logged_out, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      flash.now[:errors] = ["invalid username or password"]
      render :new
    else
      login_user!(@user)
      redirect_to goals_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
