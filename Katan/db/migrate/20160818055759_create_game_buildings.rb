class CreateGameBuildings < ActiveRecord::Migration
  def change
    create_table :game_buildings do |t|
      t.string :building_type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
