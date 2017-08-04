# frozen_string_literal: true

FactoryGirl.define do
  factory :reply_serif do
    word { Faker::Lorem.characters(20) }
  end

end
