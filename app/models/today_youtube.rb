class TodayYoutube < ActiveRecord::Base
  attr_accessible :description, :priority, :title, :url
  validates_uniqueness_of :url
end
