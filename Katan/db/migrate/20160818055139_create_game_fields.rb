class CreateGameFields < ActiveRecord::Migration
  def change
    create_table :game_fields do |t|
      t.integer :game_resource_id
      t.integer :number

      t.timestamps null: false
    end
  end
end
