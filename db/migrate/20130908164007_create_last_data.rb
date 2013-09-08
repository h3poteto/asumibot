class CreateLastData < ActiveRecord::Migration
  def change
    create_table :last_data do |t|
      t.string :category
      t.string :tweet_id

      t.timestamps
    end
  end
end
