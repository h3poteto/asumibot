FactoryGirl.define do
  factory :already_serif do
    word { Faker::Lorem.characters(20) }
  end

end
