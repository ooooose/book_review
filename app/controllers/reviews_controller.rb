class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book = Book.find_by(id: params[:book_id])
  end
  
  def create
    @book = Book.find_by(id: params[:book_id])
    @review = current_user.reviews.find_or_create_by(review_params.merge(book_id: params[:book_id]))
    if @review.save!
      flash[:success] = '保存しました'
      redirect_to @book
    end
  end
  

  def edit
    @review = Review.find_by(book_id: params[:book_id])
    @book = Book.find_by(id: params[:book_id])
  end
  
  def update
    @review = Review.find_by(book_id: params[:book_id])
    @book = Book.find_by(id: params[:book_id])
    if @review.update!(review_params)
      flash[:success] = '編集に成功しました'
      redirect_to @book
    end
  end
  
  def show
    @book = Book.find_by(id: params[:book_id])
    @review = Review.find_by(book_id: params[:book_id])
  end
  

  
  private
  def review_params
    params.require(:review).permit(:content,:evaluation)
  end

  
  
end
