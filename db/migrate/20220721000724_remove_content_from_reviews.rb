class RemoveContentFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :content, :string
  end
end
