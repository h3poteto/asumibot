FactoryGirl.define do
  factory :blog do
    title { Faker::Name.title }
    link { Faker::Internet.url }
  end

end
