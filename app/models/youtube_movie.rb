class YoutubeMovie < ActiveRecord::Base
  has_many :youtube_fav_users, :foreign_key => :youtube_movie_id
  has_many :fav_users, :through => :youtube_fav_users
  has_many :youtube_rt_users, :foreign_key => :youtube_movie_id
  has_many :rt_users, :through => :youtube_rt_users
  validates_uniqueness_of :url
end
