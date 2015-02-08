class Schedule < ActiveRecord::Base
  validates_uniqueness_of :task
end
