class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :point
      t.string :secret_token

      t.timestamps null: false
    end
  end
end
