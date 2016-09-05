class CreateGameBuildings < ActiveRecord::Migration
  def change
    create_table :game_buildings do |t|
      t.integer :building_type_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
