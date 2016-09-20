class CreateGameMaps < ActiveRecord::Migration
  def change
    create_table :game_maps do |t|
      t.timestamps null: false
    end
  end
end
