FactoryGirl.define do
  factory :youtube_fav_user do
    association :fav_user, factory: :user
    association :fav_youtube, factory: :youtube_movie
  end

end
