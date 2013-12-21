class Patient < ActiveRecord::Base

  has_many :asumi_tweets
  has_many :asumi_levels

  attr_accessible :level, :name, :twitter_id, :nickname, :description, :icon, :friend, :follower, :all_tweet, :clear, :since_id, :asumi_count, :tweet_count, :prev_level, :asumi_word, :locked, :disabled, :protect
  validates_uniqueness_of :twitter_id

  validates :twitter_id, :presence => true


  def self.rankings
    rank = Patient.where(disabled: false).where(locked: false).where(protect: false).where("tweet_count >?", 10).order("level DESC")
    return rank
  end
  def self.avail_rankings
    rank = Patient.where(disabled: false).where(locked: false).where(protect: false).where("tweet_count >?", 10).where("level >?", 20).order("level DESC")
    return rank
  end

end
