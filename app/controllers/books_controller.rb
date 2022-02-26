class BooksController < ApplicationController
  
  def serch
    @books = []
    @keyword = params[:keyword]
    if @keyword.present?
      #この部分でresultsに楽天APIから取得したデータ（jsonデータ）を格納します。
      #今回は書籍のタイトルを検索して、一致するデータを格納するように設定しています。
      results = RakutenWebService::Books::Book.search({
        title: @keyword,
      })
      #この部分で「@books」にAPIからの取得したJSONデータを格納していきます。
      #read(result)については、privateメソッドとして、設定しております。
      results.each do |result|
        @books << result
      end
    end
  end
  
  def reset
    @books.destroy
    render '/search'
  end
      
      
  def index
    user = User.find_by(id: params[:user_id])
    @books = user.books.all.page(params[:page]).per(6)
  end
  
  def show
    @book =Book.find_by(id: params[:id])
    books = Book.where(isbn: @book.isbn)
    @posts = Post.where(book_id: books.ids).order(created_at: :desc).page(params[:page]).per(10)
    total = 0
    count = 0
    books.each do |book|
      unless book.review.nil?
        total += book.review.evaluation
        count += 1
      end
    end
    if count != 0
      @eval_avg = total / count
    else
      @eval_avg = 0
    end
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
    books = Book.all.group_by(&:isbn)
    # 月間いいねの数をカウント
    book_like_count= {}
    monthly_likes = Like.all.where(created_at: Time.current.all_month)
    books.values.each do |book|
      likes = 0
      book.each do |b|
        likes += monthly_likes.where(post_id: b.posts.ids).pluck(:id).count
      end
      book_like_count.store(book[0], likes)
    end
    @book_liked_ranks = book_like_count.sort_by { |_, v| v }.reverse.to_h.take(5)
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
 
