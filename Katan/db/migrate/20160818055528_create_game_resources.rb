class CreateGameResources < ActiveRecord::Migration
  def change
    create_table :game_resources do |t|
      t.integer :resource_type_id

      t.timestamps null: false
    end
  end
end
