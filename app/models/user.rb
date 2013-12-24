class User < ActiveRecord::Base
  attr_accessible :screen_name, :twitter_id
  validates_uniqueness_of :twitter_id
end
