FactoryGirl.define do
  factory :youtube_movie do
    title { Faker::Name.title }
    url { Faker::Internet.url }
    description { Faker::Lorem.characters(100) }
  end

end
