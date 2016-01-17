# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  twitter_id  :integer
#  screen_name :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class User < ActiveRecord::Base
  has_many :youtube_fav_users, :foreign_key => :user_id
  has_many :fav_youtubes, :through => :youtube_fav_users
  has_many :niconico_fav_users, :foreign_key => :user_id
  has_many :fav_niconicos, :through => :niconico_fav_users
  has_many :youtube_rt_users, :foreign_key => :user_id
  has_many :rt_youtubes, :through => :youtube_rt_users
  has_many :niconico_rt_users, :foreign_key => :user_id
  has_many :rt_niconicos, :through => :niconico_rt_users

  validates_uniqueness_of :twitter_id

  def self.find_or_create(screen_name, twitter_id)
    user = User.where(twitter_id: twitter_id).try(:first)
    if user.blank?
      user = User.create(screen_name: screen_name, twitter_id: twitter_id)
    end
    user
  end
end
