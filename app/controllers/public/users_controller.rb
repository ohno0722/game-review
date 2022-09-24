class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def unsubscribe
    @user = current_user
  end


  def update
     @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def withdrawa
    @user = current_user
    @user.update_columns(is_deleted: true)
    if @user.is_deleted == true
      sign_out current_user
    end
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

   private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :email, :is_deleted)
  end

end
