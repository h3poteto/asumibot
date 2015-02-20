FactoryGirl.define do
  factory :schedule do
    task { Faker::Lorem.characters(10) }
    time { Time.current }
  end

end
