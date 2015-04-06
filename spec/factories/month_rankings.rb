FactoryGirl.define do
  factory :month_ranking do
    patient
    level { [0..100].sample }
  end

end
