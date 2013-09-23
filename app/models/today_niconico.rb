class TodayNiconico < ActiveRecord::Base
  attr_accessible :description, :priority, :title, :url, :used
  validates_uniqueness_of :url
end
