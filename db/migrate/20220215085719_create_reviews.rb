class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :book_id

      t.timestamps
    end
  end
end
