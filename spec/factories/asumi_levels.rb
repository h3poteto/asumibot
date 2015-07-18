FactoryGirl.define do
  factory :asumi_level do
    association :patient, factory: :patient
    asumi_count { Faker::Number.number(2) }
    tweet_count { Faker::Number.number(3) }
    asumi_word { Faker::Number.number(2) }

    factory :low_asumi_level do
      asumi_count { Faker::Number.number(1) }
      tweet_count { Faker::Number.number(3) }
      asumi_word { Faker::Number.number(1) }
    end
    factory :high_asumi_level do
      asumi_count { 99 }
      tweet_count { 100 }
      asumi_word { 99 }
    end
  end

end
