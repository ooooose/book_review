class UsersController < ApplicationController
  before_action :signin_user, only: [:index, :show, :edit, :update, :destroy]
  
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーの作成に成功しました'
      redirect_to users_path
    else
      flash[:danger] = 'ユーザーの登録に失敗しました'
      render 'new'
    end
  end  

  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params) && current_user
      flash[:success] = 'ユーザー情報を更新しました'
      redirect_to user_path(@user)
    else
      flash[:danger] = 'ユーザー情報の更新に失敗しました'
      render 'edit'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @books = @user.books.all
  end
  
  def destroy
    user = User.find_by(id: params[:id])
    if current_user
      user.destroy
      flash[:success] = "ユーザーの削除に成功しました"
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    def signin_user
      redirect_to root_url unless log_in?
    end
  
end
