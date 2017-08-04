# frozen_string_literal: true

# == Schema Information
#
# Table name: serifs
#
#  id         :integer          not null, primary key
#  type       :string(255)
#  word       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :serif do
    word { Faker::Lorem.characters(20) }
    factory :serif_new do
      type { "NewSerif" }
    end
  end

end
