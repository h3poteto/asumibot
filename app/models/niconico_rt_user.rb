class NiconicoRtUser < ActiveRecord::Base
  belongs_to :rt_niconico, :class_name => 'NiconicoMovie', :foreign_key => :niconico_movie_id
  belongs_to :rt_user, :class_name => 'User', :foreign_key => :user_id
end
