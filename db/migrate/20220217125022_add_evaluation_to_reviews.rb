class AddEvaluationToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :evaluation, :float
  end
end
