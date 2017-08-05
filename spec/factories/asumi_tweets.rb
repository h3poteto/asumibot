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

FactoryGirl.define do
  factory :asumi_tweet do
    patient_id { Patient.all.present? ? Patient.all.first : create(:patient).id }
    tweet { Faker::Lorem.characters(100) }
    tweet_id { Faker::Number.number(10).to_s }
    tweet_time { Time.current }
  end

end
