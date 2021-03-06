class PostsController < ApplicationController
  
  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました'  
      redirect_to posts_url
    else
      flash[:danger] = '投稿に失敗しました'
      redirect_to posts_url 
    end
  end
  

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:success] = '編集に成功しました'
      redirect_to posts_url
    else
      flash[:danger] = '編集に失敗しました'
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = '投稿を削除しました'
      redirect_to posts_url
    else
      flash[:danger] = '削除に失敗しました'
      render 'show'
    end
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments.order(created_at: :desc)
  end

  def index
    followings_member = current_user.followings
    @posts = Post.where(user_id: [current_user.id, *followings_member.ids]).order(created_at: :desc).page(params[:page]).per(10)
  end
  
  private
  def post_params
    params.require(:post).permit(:content,:user_id,:book_id)
  end
  
end
