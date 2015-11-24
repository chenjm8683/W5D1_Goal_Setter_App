class CheersController < ApplicationController
  def create
    @cheer = current_user.cheers.new(cheer_params)

    @cheer.save
    flash[:errors] = @cheer.errors.full_messages
    redirect_to goal_url(@cheer.goal_id)
  end

  def index
    @results = Cheer.find_by_sql("
      SELECT u.username, COUNT(*) as cheer_count
      FROM cheers c
      JOIN goals g on c.goal_id = g.id
      JOIN users u on g.user_id = u.id
      GROUP BY u.username
      ORDER BY COUNT(*) DESC"
    )
  end

  def cheer_params
    params.permit(:goal_id)
  end
end
