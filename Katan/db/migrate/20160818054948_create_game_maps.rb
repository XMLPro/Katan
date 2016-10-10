class CreateGameMaps < ActiveRecord::Migration
  def change
    create_table :game_maps do |t|
      t.integer :max_member, default: 4
      t.integer :turn_number, default: 0
      t.boolean :first, default: true
      t.boolean :first2, default: true
      t.boolean :start, default: false
      t.timestamps null: false
    end
  end
end
