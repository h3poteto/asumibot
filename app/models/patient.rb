class Patient < ActiveRecord::Base
  has_many :asumi_tweets
  has_many :asumi_levels
  has_one :month_ranking

  validates_uniqueness_of :twitter_id

  validates :twitter_id, :presence => true

  scope :available, -> { where(disabled: false).where(locked: false).where(protect: false) }

  def self.rankings
    rank = Patient.available.where("prev_tweet_count >?", 10).order("level DESC")
    return rank
  end
  def self.avail_rankings
    rank = Patient.available.where("prev_tweet_count >?", 10).where("level >?", 20).order("level DESC")
    return rank
  end

  def self.avail_prev_rankings
    prev_rank = Patient.available.where("prev_level_tweet >?", 10).order("prev_level DESC")
    return prev_rank
  end

  def asumi_calculate
    if tweet_count == 0
      return 0
    end
    m = asumi_count.to_f / tweet_count.to_f
    m = m * 100
  end
end
