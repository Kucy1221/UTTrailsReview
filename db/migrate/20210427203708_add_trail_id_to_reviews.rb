class AddTrailIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :trail_id, :int
  end
end
