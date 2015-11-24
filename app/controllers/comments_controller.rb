class CommentsController < ApplicationController


  def create
    @comment = current_user.authored_comments.new(comment_params)
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to_page(@comment)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to_page(@comment)
  end

  def redirect_to_page(comment)
    if comment.commentable_type == "User"
      redirect_to user_url(comment.commentable_id)
    else
      redirect_to goal_url(comment.commentable_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
