class AddRatingToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :rating, :int
  end
end
