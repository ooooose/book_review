class BooksController < ApplicationController
  
  def index
    user = User.find_by(id: params[:user_id])
    @books = user.books.all.page(params[:page]).per(6)
  end
  
  def show
    @book =Book.find_by(id: params[:id])
    book_reviews @book
    books = Book.where(isbn: @book.isbn)
    @posts = Post.where(book_id: books.ids).order(created_at: :desc).page(params[:page]).per(10)
  end

  
  def new
  end
  
  def create
    @book = current_user.books.find_or_initialize_by(isbn: params[:isbn])
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = current_user.books.build(read(results.first))
      @book.save
      flash[:success] = '保存しました'
      redirect_to posts_url
    end
  end
    
    
  def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
    flash[:success] = '削除しました'
    redirect_to posts_url
  end
  
  def ranking
    @books = Book.all.group_by(&:isbn)
    # 月間いいねの数をカウント
    rank @books
  end
  
  
  private
  #「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url
    }
  end
  
  
end
 
