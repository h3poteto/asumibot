# frozen_string_literal: true

class AddColumnDescriptionToYoutubeMovies < ActiveRecord::Migration[4.2]
  def change
    add_column :youtube_movies, :description, :text, :after => 'url'
  end
end
