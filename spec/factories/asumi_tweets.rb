# frozen_string_literal: true

# == Schema Information
#
# Table name: asumi_tweets
#
#  id         :integer          not null, primary key
#  patient_id :integer
#  tweet      :string(255)
#  tweet_id   :string(255)      indexed
#  tweet_time :datetime         not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_asumi_tweets_on_tweet_id  (tweet_id) UNIQUE
#

FactoryGirl.define do
  factory :asumi_tweet do
    patient_id { Patient.all.present? ? Patient.all.first : create(:patient).id }
    tweet { Faker::Lorem.characters(100) }
    tweet_id { Faker::Number.number(10).to_s }
    tweet_time { Time.current }
  end

end
