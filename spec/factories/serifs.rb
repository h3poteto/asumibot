FactoryGirl.define do
  factory :serif do
    word { Faker::Lorem.characters(20) }
    factory :serif_new do
      type { "NewSerif" }
    end
  end

end
