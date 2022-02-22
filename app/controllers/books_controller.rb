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
    @books = user.books.all
  end
  
  def show
    @book = Book.find_by(id: params[:id])
    @review = @book.review
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
 
