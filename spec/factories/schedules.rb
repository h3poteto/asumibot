# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  task       :string(255)
#  time       :datetime
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :schedule do
    task { Faker::Lorem.characters(10) }
    time { Time.current }
  end

end
