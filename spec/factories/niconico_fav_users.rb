FactoryGirl.define do
  factory :niconico_fav_user do
    association :fav_user, factory: :user
    association :fav_niconico, factory: :niconico_movie
  end

end
