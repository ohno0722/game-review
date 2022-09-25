class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save!
      redirect_to reviews_path, notice: "You have created review successfully."
    else
      @reviews = Review.all
      render 'index'
    end
  end

  def index
    if params[:search] == nil
      @reviews= Review.all
    elsif params[:search] == ''
      @reviews= Review.all
    else
      @reviews = Review.where("body LIKE ? ",'%' + params[:search] + '%')
      .or(Review.where("title LIKE ? ",'%' + params[:search] + '%'))
      .or(Review.where("category LIKE ? ",'%' + params[:search] + '%'))
    end
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
      redirect_to review_path(@review), notice: "You have updated review successfully."
    else
      render "edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path, notice: "successfully delete review!"
  end

   private

  def review_params
    params.require(:review).permit(:title, :body, :category, :rate)
  end

end
