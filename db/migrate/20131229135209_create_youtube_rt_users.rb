class CreateYoutubeRtUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :youtube_rt_users do |t|
      t.integer :user_id
      t.integer :youtube_movie_id
      t.timestamps
    end
  end
end
