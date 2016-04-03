# == Schema Information
#
# Table name: niconico_movies
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :text(65535)
#  priority    :boolean
#  disabled    :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class NiconicoMovie < ActiveRecord::Base
  has_many :niconico_fav_users, :foreign_key => :niconico_movie_id
  has_many :fav_users, :through => :niconico_fav_users
  has_many :niconico_rt_users, :foreign_key => :niconico_movie_id
  has_many :rt_users, :through => :niconico_rt_users
  validates_uniqueness_of :url

  scope :available, -> { where(disabled: false) }
end
