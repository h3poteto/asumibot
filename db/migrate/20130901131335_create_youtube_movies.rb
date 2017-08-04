class CreateYoutubeMovies < ActiveRecord::Migration[4.2]
  def change
    create_table :youtube_movies do |t|
      t.string :title
      t.string :url
      t.integer :priority

      t.timestamps
    end
  end
end
