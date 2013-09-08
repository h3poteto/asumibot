class YoutubeMovie < ActiveRecord::Base
  attr_accessible :priority, :title, :url, :description
  validates_uniqueness_of :url
end
