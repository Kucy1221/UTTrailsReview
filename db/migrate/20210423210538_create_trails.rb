class CreateTrails < ActiveRecord::Migration[6.1]
  def change
    create_table :trails do |t|
      t.string :name
      t.decimal :rating

      t.timestamps
    end
  end
end
