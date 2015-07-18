FactoryGirl.define do
  factory :youtube_rt_user do
    association :rt_user, factory: :user
    association :rt_youtube, factory: :youtube_movie
  end

end
