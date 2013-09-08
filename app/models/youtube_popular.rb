class YoutubePopular < ActiveRecord::Base
  attr_accessible :title, :priority, :url, :description, :disabled, :used
end
