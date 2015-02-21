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
  end

end
