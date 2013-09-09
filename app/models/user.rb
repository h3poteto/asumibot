class User < ActiveRecord::Base
  has_many :youtube_users, :dependent => :destroy
  has_many :youtube_movies, :through => :youtube_users
  attr_accessible :screen_name, :twitter_id
  validates_uniqueness_of :twitter_id
end
