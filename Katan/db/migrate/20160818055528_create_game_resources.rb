class CreateGameResources < ActiveRecord::Migration
  def change
    create_table :game_resources do |t|
      t.string :resources_type

      t.timestamps null: false
    end
  end
end
