class NiconicoFavUser < ActiveRecord::Base
  belongs_to :fav_niconico, :class_name => 'NiconicoMovie', :foreign_key => :niconico_movie_id
  belongs_to :fav_user, :class_name => 'User', :foreign_key => :user_id
end
