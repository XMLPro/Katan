class CreateGameMaps < ActiveRecord::Migration
  def change
    create_table :game_maps do |t|
      t.integer :game_field_id
      t.integer :max_member, default: 4
      t.integer :turn_number, default: 0
      t.timestamps null: false
    end
  end
end
