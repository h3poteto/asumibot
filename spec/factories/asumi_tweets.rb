FactoryGirl.define do
  factory :asumi_tweet do
    patient_id { Patient.all.present? ? Patient.all.first : create(:patient).id }
    tweet { Faker::Lorem.characters(100) }
    tweet_id { Faker::Number.number(10).to_s }
    tweet_time { Time.current }
  end

end
