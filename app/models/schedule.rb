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

class Schedule < ApplicationRecord
  validates_uniqueness_of :task
end
