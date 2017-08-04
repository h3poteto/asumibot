# == Schema Information
#
# Table name: last_data
#
#  id         :integer          not null, primary key
#  category   :string(255)
#  tweet_id   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :last_data, :class => 'LastData' do
    category { 'mention' }
    tweet_id { Faker::Number.number(10).to_s }
  end

end
