# frozen_string_literal: true

FactoryGirl.define do
  factory :new_serif do
    word { Faker::Lorem.characters(100) }
  end

end
