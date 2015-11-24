class CheersController < ApplicationController
  def create
    @cheer = current_user.cheers.new(cheer_params)

    @cheer.save
    flash[:errors] = @cheer.errors.full_messages
    redirect_to goal_url(@cheer.goal_id)
  end

  def cheer_params
    params.permit(:goal_id)
  end
end
