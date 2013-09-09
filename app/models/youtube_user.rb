class YoutubeUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :youtube_movie
  attr_accessible :user_id, :youtube_movie_id
end
