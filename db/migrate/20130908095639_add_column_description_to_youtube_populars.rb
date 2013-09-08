class AddColumnDescriptionToYoutubePopulars < ActiveRecord::Migration
  def change
    add_column :youtube_populars, :description, :text, :after => 'url'
  end
end
