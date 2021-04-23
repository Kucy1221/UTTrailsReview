class RemoveTimeCreatedFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :time_created, :datetime
  end
end
