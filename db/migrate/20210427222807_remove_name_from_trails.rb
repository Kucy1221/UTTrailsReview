class RemoveNameFromTrails < ActiveRecord::Migration[6.1]
  def change
    remove_column :trails, :name, :string
    add_column :trails, :primaryname, :string
  end
end
