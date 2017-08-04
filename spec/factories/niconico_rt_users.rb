# == Schema Information
#
# Table name: niconico_rt_users
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  niconico_movie_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

FactoryGirl.define do
  factory :niconico_rt_user do
    association :rt_user, factory: :user
    association :rt_niconico, factory: :niconico_movie
  end
end
