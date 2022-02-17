class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book = Book.find_by(id: params[:id])
  end
  
  def create
    @book = Book.find_by(id: params[:book_id])
    @review = current_user.reviews.create(review_params.merge(book_id: @book.id))
    if @review.save!
      flash[:success] = '保存しました'
      redirect_to @book
    end
  end
  

  def edit
    @review = Review.find_by(id: params[:id])
    @book = Book.find_by(id: @review.book_id)
  end
  
  def update
    @review = Review.find_by(id: params[:id])
    @book = Book.find_by(id: params[:book_id])
    if @review.update!(review_params)
      flash[:success] = '編集に成功しました'
      redirect_to @book
    end
  end
  
  
  private
  def review_params
    params.require(:review).permit(:content,:evaluation)
  end

  
  
end
