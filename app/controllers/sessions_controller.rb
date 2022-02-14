class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: sessions_params[:email])
    if user && user.authenticate(sessions_params[:password])
      log_in(user)
      remember user
      flash[:success] = 'ログインに成功しました'
      redirect_to users_url
    else
      flash[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end
  
  def destroy
    user = User.find(session[:user_id])
    log_out(user)
    flash[:success] = 'ログアウトしました'
    redirect_to login_url
  end
  
  
  private
    def sessions_params
      params.require(:session).permit(:email, :password)
    end
    

  
end
