class CreateGameSides < ActiveRecord::Migration
  def change
    create_table :game_sides do |t|
      t.integer :gamebuilding_id

      t.timestamps null: false
    end
  end
end
