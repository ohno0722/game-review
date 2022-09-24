class Admin::CommentsController < ApplicationController

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
      redirect_to admin_review_path(params[:review_id])

  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
