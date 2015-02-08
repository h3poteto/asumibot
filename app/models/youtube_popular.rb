class YoutubePopular < ActiveRecord::Base
  validates_uniqueness_of :url
end
