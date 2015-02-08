class Patient < ActiveRecord::Base
  has_many :asumi_tweets
  has_many :asumi_levels

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

  def self.avail_prev_rankings
    prev_rank = Patient.where(disabled: false).where(locked: false).where(protect: false).where("prev_tweet_count >?", 10).order("prev_level DESC")
    return prev_rank
  end
end
