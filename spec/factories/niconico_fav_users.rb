# == Schema Information
#
# Table name: niconico_fav_users
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  niconico_movie_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

FactoryGirl.define do
  factory :niconico_fav_user do
    association :fav_user, factory: :user
    association :fav_niconico, factory: :niconico_movie
  end

end
