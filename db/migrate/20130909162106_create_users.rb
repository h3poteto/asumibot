class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :twitter_id
      t.string :screen_name

      t.timestamps
    end
  end
end
