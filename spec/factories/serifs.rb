FactoryGirl.define do
  factory :serif do
    word { Faker::Lorem.characters(20) }
  end

end
