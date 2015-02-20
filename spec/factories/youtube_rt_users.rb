FactoryGirl.define do
  factory :youtube_rt_user do
    factory :youtube_rt_each_user do
      user_id { create(:user).id }
      youtube_movie_id { YoutubeMovie.all.present? ? YoutubeMovie.all.first.id : create(:youtube_movie).id }
    end
  end

end
