class YoutubePopular < ActiveRecord::Base
  attr_accessible :title, :priority, :url, :description, :disabled, :used
  validates_uniqueness_of :url
end
