class CreateNiconicoFavUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :niconico_fav_users do |t|
      t.integer :user_id
      t.integer :niconico_movie_id

      t.timestamps
    end
  end
end
