class YoutubeMovie < ActiveRecord::Base
  has_many :youtube_users, :dependent => :destroy
  has_many :users, :through => :youtube_users
  attr_accessible :priority, :title, :url, :description, :disabled
  validates_uniqueness_of :url
end
