class CreateGameSides < ActiveRecord::Migration
  def change
    create_table :game_sides do |t|
      t.integer :game_building_id
      t.integer :game_map_id
      t.integer :positionA
      t.integer :positionB
      t.integer :position

      t.timestamps null: false
    end
  end
end
