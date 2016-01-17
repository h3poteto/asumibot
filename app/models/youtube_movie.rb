# == Schema Information
#
# Table name: youtube_movies
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :text(65535)
#  priority    :integer
#  disabled    :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class YoutubeMovie < ActiveRecord::Base
  has_many :youtube_fav_users, :foreign_key => :youtube_movie_id
  has_many :fav_users, :through => :youtube_fav_users
  has_many :youtube_rt_users, :foreign_key => :youtube_movie_id
  has_many :rt_users, :through => :youtube_rt_users
  validates_uniqueness_of :url

  scope :available, -> { where(disabled: false) }
end
