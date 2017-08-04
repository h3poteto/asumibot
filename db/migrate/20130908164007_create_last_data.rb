class CreateLastData < ActiveRecord::Migration[4.2]
  def change
    create_table :last_data do |t|
      t.string :category
      t.string :tweet_id

      t.timestamps
    end
  end
end
