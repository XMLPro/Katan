class CreateGameFields < ActiveRecord::Migration
  def change
    create_table :game_fields do |t|
      t.integer :resource_type_id
      t.integer :game_map_id
      t.integer :number

      t.timestamps null: false
    end
  end
end
