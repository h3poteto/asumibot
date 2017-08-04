class CreateNiconicoRtUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :niconico_rt_users do |t|
      t.integer :user_id
      t.integer :niconico_movie_id
      t.timestamps
    end
  end
end
