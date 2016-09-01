class CreateGameSides < ActiveRecord::Migration
  def change
    create_table :game_sides do |t|
      t.integer :game_building_id

      t.timestamps null: false
    end
  end
end
