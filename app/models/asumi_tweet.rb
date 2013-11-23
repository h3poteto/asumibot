class AsumiTweet < ActiveRecord::Base
  belongs_to :patients

  attr_accessible :patient_id, :tweet, :tweet_id, :tweet_time
end
