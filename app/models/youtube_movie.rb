class YoutubeMovie < ActiveRecord::Base
  attr_accessible :priority, :title, :url
  validates_uniqueness_of :url
end
