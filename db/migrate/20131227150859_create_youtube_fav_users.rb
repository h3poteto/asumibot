class CreateYoutubeFavUsers < ActiveRecord::Migration
  def change
    create_table :youtube_fav_users do |t|
      t.integer :user_id
      t.integer :youtube_movie_id

      t.timestamps
    end
  end
end
