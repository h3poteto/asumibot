class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :twitter_id
      t.string :name
      t.integer :level
      t.integer :asumi_count
      t.integer :tweet_count
      t.integer :prev_level
      t.string :since_id
      t.boolean :clear, :default => 0, :null => false

      t.timestamps
    end
  end
end
