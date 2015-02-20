FactoryGirl.define do
  factory :niconico_rt_user do
    factory :niconico_rt_each_user do
      user_id { create(:user).id }
      niconico_movie_id { NiconicoMovie.all.present? ? NiconicoMovie.all.first.id : create(:niconico_movie).id }
    end
  end
end
