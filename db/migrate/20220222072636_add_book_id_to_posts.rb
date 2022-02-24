class AddBookIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :book_id, :integer
  end
end
