class TodayNiconico < ActiveRecord::Base
  validates_uniqueness_of :url
end
