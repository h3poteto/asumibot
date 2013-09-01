class CreateYoutubePopulars < ActiveRecord::Migration
  def change
    create_table :youtube_populars do |t|
      t.string :title
      t.string :url
      t.integer :priority

      t.timestamps
    end
  end
end
