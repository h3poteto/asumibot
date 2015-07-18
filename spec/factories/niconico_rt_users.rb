FactoryGirl.define do
  factory :niconico_rt_user do
    association :rt_user, factory: :user
    association :rt_niconico, factory: :niconico_movie
  end
end
