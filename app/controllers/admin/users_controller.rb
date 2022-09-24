class Admin::UsersController < ApplicationController
  def index
     @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

      if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to admin_user_path
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :email, :id, :is_deleted)
  end


end
