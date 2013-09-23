class CreateNiconicoPopulars < ActiveRecord::Migration
  def change
    create_table :niconico_populars do |t|
      t.string :title
      t.string :url
      t.string :description
      t.integer :priority
      t.boolean :used, :default => 0, :null => false
      t.boolean :disabled, :default => 0, :null => false

      t.timestamps
    end
  end
end
