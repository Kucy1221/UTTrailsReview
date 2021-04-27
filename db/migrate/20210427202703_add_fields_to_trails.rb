class AddFieldsToTrails < ActiveRecord::Migration[6.1]
  def change
    add_column :trails, :xid, :int
    add_column :trails, :hikedifficulty, :string
    add_column :trails, :bikedifficulty, :string
    add_column :trails, :designateduses, :string
    add_column :trails, :recreationarea, :string
    #:hikedifficulty => trail['attributes']['hikedifficulty'],
    #:bikedifficulty => trail['attributes']['bikedifficulty'],
    #:designateduses => trail['attributes']['designateduses'],
    #:recreationarea => trail['attributes']['recreationarea']
  end
end
