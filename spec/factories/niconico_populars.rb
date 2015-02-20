FactoryGirl.define do
  factory :niconico_popular do
    title { Faker::Name.title }
    url { Faker::Internet.url }
    description { Faker::Lorem.characters(100) }
  end

end
