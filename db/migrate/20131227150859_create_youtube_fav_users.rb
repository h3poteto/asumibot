# frozen_string_literal: true

class CreateYoutubeFavUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :youtube_fav_users do |t|
      t.integer :user_id
      t.integer :youtube_movie_id

      t.timestamps
    end
  end
end
