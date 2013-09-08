class AddColumnDescriptionToYoutubeMovies < ActiveRecord::Migration
  def change
    add_column :youtube_movies, :description, :text, :after => 'url'
  end
end
