class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def search_review
    @review=Review.new
    @reviews = Review.search(params[:keyword])
  end

  def show
    @review = Review.find(params[:id])
    @user = User.find_by(id: @review.user_id)
    @comment = Comment.new
    @comments = @review.comments
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

      if @review.update(review_params)
        flash[:notice] = "You have updated review successfully"
        redirect_to admin_review_path
      end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path, notice: "successfully delete review!"
  end

   private

  def review_params
    params.require(:review).permit(:title, :body, :category, :rate)
  end

end
