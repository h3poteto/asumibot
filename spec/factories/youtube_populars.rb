# frozen_string_literal: true

# == Schema Information
#
# Table name: youtube_populars
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :text(65535)
#  priority    :integer
#  used        :boolean          default(FALSE), not null
#  disabled    :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :youtube_popular do
    title { Faker::Name.title }
    url { Faker::Internet.url }
    description { Faker::Lorem.characters(100) }
  end

end
