# frozen_string_literal: true

# == Schema Information
#
# Table name: youtube_fav_users
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  youtube_movie_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :youtube_fav_user do
    association :fav_user, factory: :user
    association :fav_youtube, factory: :youtube_movie
  end

end
