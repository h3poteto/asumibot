# frozen_string_literal: true
# == Schema Information
#
# Table name: asumi_tweets
#
#  id         :integer          not null, primary key
#  patient_id :integer          indexed => [tweet_time]
#  tweet      :string(255)
#  tweet_id   :string(255)      indexed
#  tweet_time :datetime         not null, indexed => [patient_id]
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_asumi_tweets_on_patient_id_and_tweet_time  (patient_id,tweet_time)
#  index_asumi_tweets_on_tweet_id                   (tweet_id) UNIQUE
#

class AsumiTweet < ApplicationRecord
  belongs_to :patient

  before_save :encode_emoji

  validates_uniqueness_of :tweet_id

  def encode_emoji
    self.tweet = utf8mb4_encode_numericentity(self.tweet)
  end

  def utf8mb4_encode_numericentity(str)
    str.gsub(/[^\u{0}-\u{FFFF}]/) { '&#x%X;' % $&.ord }
  end
end
