# frozen_string_literal: true

FactoryGirl.define do
  factory :already_serif do
    word { Faker::Lorem.characters(20) }
  end

end
