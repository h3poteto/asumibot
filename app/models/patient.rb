class Patient < ActiveRecord::Base
  attr_accessible :level, :name, :twitter_id, :clear, :since_id, :asumi_count, :tweet_count, :prev_level, :asumi_word
  validates_uniqueness_of :twitter_id

  validates :twitter_id, :presence => true
end
