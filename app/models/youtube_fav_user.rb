class YoutubeFavUser < ActiveRecord::Base
  belongs_to :fav_youtube, :class_name => 'YoutubeMovie', :foreign_key => :youtube_movie_id
  belongs_to :fav_user, :class_name => 'User', :foreign_key => :user_id
end
