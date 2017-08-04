# frozen_string_literal: true

# == Schema Information
#
# Table name: youtube_rt_users
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  youtube_movie_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :youtube_rt_user do
    association :rt_user, factory: :user
    association :rt_youtube, factory: :youtube_movie
  end

end
