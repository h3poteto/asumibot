class NiconicoMovie < ActiveRecord::Base
  has_many :niconico_fav_users, :foreign_key => :niconico_movie_id
  has_many :fav_users, :through => :niconico_fav_users
  has_many :niconico_rt_users, :foreign_key => :niconico_movie_id
  has_many :rt_users, :through => :niconico_rt_users
  validates_uniqueness_of :url
end
