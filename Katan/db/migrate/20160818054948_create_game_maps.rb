class CreateGameMaps < ActiveRecord::Migration
  def change
    create_table :game_maps do |t|
      t.integer :game_field_id

      t.timestamps null: false
    end
  end
end
