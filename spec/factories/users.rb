FactoryGirl.define do
  factory :user do
    twitter_id { Faker::Number.number(10) }
    screen_name { Faker::Name.first_name }
  end

end
