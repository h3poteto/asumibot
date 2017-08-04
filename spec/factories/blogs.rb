# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  link       :string(255)
#  used       :boolean          default(FALSE)
#  post_at    :datetime
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :blog do
    title { Faker::Name.title }
    link { Faker::Internet.url }
  end

end
