class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :user_id
      t.integer :game_map_id
      # t.integer :number

      t.timestamps null: false
    end
  end
end
