class UsersController < ApplicationController
  before_action :is_maching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
    @book = Book.new
    
  end

  def index
    @user = User.find(current_user.id)
    @book =Book.new
    @users =User.page(params[:page])
    
    
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:profile_image, :introduction)
  end
  
  def is_maching_login_user
  user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
end
