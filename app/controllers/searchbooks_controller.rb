class SearchbooksController < ApplicationController
  
  def search
    # viewに表示する@booksをリスト形式で作成する。（再度検索ボタンを押すとリセットするようにしなくちゃいけない）
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
  
  def reset
    # おそらくここに@booksに格納するparamsの表記が必要（だと思う）
    @books = nil
    redirect_to '/search'
  end
end
 
