FactoryGirl.define do
  factory :last_data, :class => 'LastData' do
    category { 'mention' }
    tweet_id { Faker::Number.number(10).to_s }
  end

end
