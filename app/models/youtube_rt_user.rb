class YoutubeRtUser < ActiveRecord::Base
  belongs_to :rt_youtube, :class_name => 'YoutubeMovie', :foreign_key => :youtube_movie_id
  belongs_to :rt_user, :class_name => 'User', :foreign_key => :user_id
end
