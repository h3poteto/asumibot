# frozen_string_literal: true

class AddColumnDescriptionToYoutubePopulars < ActiveRecord::Migration[4.2]
  def change
    add_column :youtube_populars, :description, :text, :after => 'url'
  end
end
