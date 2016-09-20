class CreateVertices < ActiveRecord::Migration
  def change
    create_table :vertices do |t|
      t.integer :game_field_id
      t.integer :game_side_id
      t.integer :game_intersection_id
      t.integer :next_intersection_id

      t.timestamps null: false
    end
  end
end
