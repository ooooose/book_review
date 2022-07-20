module BooksHelper
    
  def book_reviews(book)
    books = Book.where(isbn: book.isbn)
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

  def rank(books)
    book_like_count = {}
    monthly_likes = Like.all.where(created_at: Time.current.all_month) 
    books.values.each do |book|
      likes = 0
      book.each do |b|
        likes += monthly_likes.where(post_id: b.posts.ids).pluck(:id).count
      end
      book_like_count.store(book[0], likes)
    end
    @book_liked_ranks = book_like_count.sort_by{ |_,v| v }.reverse.to_h.take(5) 
  end
end
