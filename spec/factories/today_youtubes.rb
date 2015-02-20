FactoryGirl.define do
  factory :today_youtube do
    title { Faker::Name.title }
    url { Faker::Internet.url }
    description { Faker::Lorem.characters(100) }
  end

end
