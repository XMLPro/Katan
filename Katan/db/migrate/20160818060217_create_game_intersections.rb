class CreateGameIntersections < ActiveRecord::Migration
  def change
    create_table :game_intersections do |t|
      t.integer :game_map_id
      t.integer :game_building_id
      t.integer :position

      t.timestamps null: false
    end
  end
end
