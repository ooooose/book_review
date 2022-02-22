class LikesController < ApplicationController
  before_action :post_params
  
  def create
    Like.find_or_create_by(user_id: current_user.id, post_id: params[:id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:id]).destroy
  end

  private

  def post_params
    @post = Post.find_by(id: params[:id])
  end
  
end
