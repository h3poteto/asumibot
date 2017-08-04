# == Schema Information
#
# Table name: patients
#
#  id               :integer          not null, primary key
#  twitter_id       :integer
#  name             :string(255)
#  nickname         :string(255)
#  description      :text(65535)
#  icon             :string(255)
#  all_tweet        :integer
#  friend           :integer
#  follower         :integer
#  level            :integer
#  asumi_count      :integer
#  tweet_count      :integer
#  asumi_word       :integer
#  prev_level       :integer
#  prev_level_tweet :integer
#  prev_tweet_count :integer
#  prev_asumi_word  :integer
#  since_id         :string(255)
#  clear            :boolean          default(FALSE), not null
#  protect          :boolean          default(FALSE), not null
#  locked           :boolean          default(FALSE), not null
#  disabled         :boolean          default(FALSE), not null
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :patient do
    twitter_id { Faker::Number.number(8) }
    name { Faker::Japanese::Name.name }
    nickname { Faker::Name.first_name }
    description { Faker::Lorem.characters(100) }
    icon { Faker::Internet.url }
    all_tweet { Faker::Number.number(8).to_i }
    friend { Faker::Number.number(3).to_i }
    follower { Faker::Number.number(3).to_i }
    level { Faker::Number.number(2).to_i }
    asumi_count { Faker::Number.number(2).to_i }
    tweet_count { Faker::Number.number(3).to_i }
    asumi_word { Faker::Number.number(2).to_i }
    prev_level { Faker::Number.number(2).to_i }
    prev_level_tweet { Faker::Number.number(3).to_i }
    prev_tweet_count { Faker::Number.number(3).to_i }
    prev_asumi_word { Faker::Number.number(2).to_i }
    since_id { Faker::Number.number(10).to_s }
    protect { false }
    clear { true }
  end

end
