class User < ActiveRecord::Base
  has_many :youtube_fav_users, :foreign_key => :user_id
  has_many :fav_youtubes, :through => :youtube_fav_users
  has_many :niconico_fav_users, :foreign_key => :user_id
  has_many :fav_niconicos, :through => :niconico_fav_users
  has_many :youtube_rt_users, :foreign_key => :user_id
  has_many :rt_youtubes, :through => :youtubue_rt_users
  has_many :niconico_rt_users, :foreign_key => :user_id
  has_many :rt_niconicos, :through => :niconico_rt_users
  validates_uniqueness_of :twitter_id
end
