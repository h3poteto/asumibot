# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  twitter_id  :integer
#  screen_name :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :user do
    twitter_id { Faker::Number.number(10) }
    screen_name { Faker::Name.first_name }
  end

end
