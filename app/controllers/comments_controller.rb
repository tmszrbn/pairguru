class CommentsController < ApplicationController
  before_action :require_login, only: :create

  def create
    comment = Comment.new comment_params
    if comment.save
      redirect_to movie_path(id: comment_params[:movie_id])
      flash[:success] = "Comment created succesfully."
    else
      flash[:error] = "Something went wrong. #{comment.errors.full_messages.join ". "}."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment_belongs_to_current_user?(comment)
      flash[:success] = "Uncommented successfully"
      comment.destroy
      redirect_back(fallback_location: movies_path)
    else
      flash[:error] = "Wrong user"
      redirect_back fallback_location: root_path
    end
  end

  private

  def require_login
    unless user_signed_in?
      flash[:error] = "You have to be logged in to do that"
      redirect_to new_user_session_path
    end
  end

  def comment_belongs_to_current_user?(comment)
    current_user.id == comment.user_id
  end

  def comment_params
    params.require(:comment).permit(:movie_id, :user_id, :body)
  end
end
