# == Schema Information
#
# Table name: month_rankings
#
#  id         :integer          not null, primary key
#  patient_id :integer
#  level      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MonthRanking < ActiveRecord::Base
  belongs_to :patient

  scope :level_order, -> { order('level DESC')}
end
