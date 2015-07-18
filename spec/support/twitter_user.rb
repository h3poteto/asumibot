class TwitterUser
  attr_accessor :id, :screen_name, :name, :description, :profile_image_url, :friends_count, :followers_count, :statuses_count
  def initialize
    @id = 1
    @screen_name = Faker::Internet.user_name
    @name = Faker::Internet.user_name
    @description = Faker::Lorem.characters(30)
    @profile_image_url = Faker::Internet.url
    @firends_count = Faker::Number.number(2)
    @followers_count = Faker::Number.number(2)
    @statuses_count = Faker::Number.number(5)
  end
  def protected?
    false
  end
end
