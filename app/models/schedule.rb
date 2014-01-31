class Schedule < ActiveRecord::Base
  attr_accessible :task, :time
  validates_uniqueness_of :task
end
