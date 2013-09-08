class AddColumnDisabledInYoutubeMovies < ActiveRecord::Migration
  def up
    add_column :youtube_movies, :disabled, :boolean, :default => 0, :null => false, :after => 'priority'
  end

  def down
    remove_column :youtube_movies, :disabled
  end
end
